#!/usr/bin/env bash
# shellcheck shell=bash

# Plugin specification parsing and install/update/list helpers

# Parsed spec is returned via global variables for simplicity:
# ZPM_SPEC_TYPE: git|local
# ZPM_SPEC_URL: full URL for git
# ZPM_SPEC_HOST, ZPM_SPEC_OWNER, ZPM_SPEC_NAME
# ZPM_SPEC_REF: optional ref
# ZPM_SPEC_PATH: for local type

zpm_reset_spec_vars() {
  ZPM_SPEC_TYPE=""; ZPM_SPEC_URL=""; ZPM_SPEC_HOST=""; ZPM_SPEC_OWNER=""; ZPM_SPEC_NAME=""; ZPM_SPEC_REF=""; ZPM_SPEC_PATH=""
}

zpm_parse_spec() {
  # Accept forms:
  # - owner/name[@ref]
  # - gh:owner/name[@ref], github:owner/name[@ref]
  # - https://github.com/owner/name(.git)[@ref]
  # - git@github.com:owner/name.git[@ref]
  # - ssh://git@host/owner/name.git[@ref]
  # - /absolute/path or ./relative/path (local)
  local spec="$1"
  zpm_reset_spec_vars

  # Local path
  if [[ "$spec" == /* || "$spec" == ./* || "$spec" == ../* ]]; then
    ZPM_SPEC_TYPE="local"; ZPM_SPEC_PATH="$(realpath -m "$spec")"; return 0
  fi

  local main="$spec" ref=""
  if [[ "$spec" == *@* ]]; then
    main="${spec%@*}"; ref="${spec#*@}"
  fi

  # gh: shorthand
  if [[ "$main" == gh:* || "$main" == github:* ]]; then
    local path="${main#*:}"
    local owner="${path%%/*}" name="${path#*/}"
    ZPM_SPEC_TYPE="git"
    ZPM_SPEC_HOST="github.com"
    ZPM_SPEC_OWNER="$owner"
    ZPM_SPEC_NAME="$name"
    ZPM_SPEC_REF="$ref"
    ZPM_SPEC_URL="https://github.com/${owner}/${name}.git"
    return 0
  fi

  # Full http(s) URL
  if [[ "$main" =~ ^https?:// ]]; then
    ZPM_SPEC_TYPE="git"
    ZPM_SPEC_URL="$main"
    # Attempt to extract host/owner/name if github-like
    local gh_pat='^https?://([^/]+)/([^/]+)/([^/.]+)(\.git)?'
    if [[ "$main" =~ $gh_pat ]]; then
      ZPM_SPEC_HOST="${BASH_REMATCH[1]}"; ZPM_SPEC_OWNER="${BASH_REMATCH[2]}"; ZPM_SPEC_NAME="${BASH_REMATCH[3]}"
    fi
    ZPM_SPEC_REF="$ref"
    return 0
  fi

  # SSH forms
  if [[ "$main" =~ ^git@([^:]+):([^/]+)/([^/.]+)(\.git)?$ ]]; then
    ZPM_SPEC_TYPE="git"
    ZPM_SPEC_HOST="${BASH_REMATCH[1]}"; ZPM_SPEC_OWNER="${BASH_REMATCH[2]}"; ZPM_SPEC_NAME="${BASH_REMATCH[3]}"
    ZPM_SPEC_URL="${main}"
    ZPM_SPEC_REF="$ref"
    return 0
  fi
  if [[ "$main" =~ ^ssh://[^/]+/([^/]+)/([^/.]+)(\.git)?$ ]]; then
    ZPM_SPEC_TYPE="git"
    ZPM_SPEC_HOST="unknown"; ZPM_SPEC_OWNER="${BASH_REMATCH[1]}"; ZPM_SPEC_NAME="${BASH_REMATCH[2]}"
    ZPM_SPEC_URL="${main}"
    ZPM_SPEC_REF="$ref"
    return 0
  fi

  # owner/name (default github)
  if [[ "$main" == */* ]]; then
    local owner="${main%%/*}" name="${main#*/}"
    ZPM_SPEC_TYPE="git"
    ZPM_SPEC_HOST="github.com"
    ZPM_SPEC_OWNER="$owner"
    ZPM_SPEC_NAME="$name"
    ZPM_SPEC_REF="$ref"
    ZPM_SPEC_URL="https://github.com/${owner}/${name}.git"
    return 0
  fi

  die "Invalid plugin spec: ${spec}"
}

zpm_install_one() {
  local spec="$1"
  zpm_parse_spec "$spec"
  if [[ "$ZPM_SPEC_TYPE" == "local" ]]; then
    zpm_info "Using local plugin: ${ZPM_SPEC_PATH}"
    return 0
  fi
  local dest
  dest="$(zpm_repo_path "${ZPM_SPEC_HOST:-unknown}" "${ZPM_SPEC_OWNER:-unknown}" "${ZPM_SPEC_NAME:-unknown}")"
  if [[ -d "$dest" ]]; then
    zpm_info "Already present: ${ZPM_SPEC_OWNER}/${ZPM_SPEC_NAME}"
    return 0
  fi
  zpm_with_lock "${ZPM_SPEC_HOST}-${ZPM_SPEC_OWNER}-${ZPM_SPEC_NAME}" -- \
    zpm_clone_shallow "${ZPM_SPEC_URL}" "$dest" "${ZPM_SPEC_REF:-}"
  zpm_info "Installed: ${ZPM_SPEC_OWNER}/${ZPM_SPEC_NAME}${ZPM_SPEC_REF:+@$ZPM_SPEC_REF}"
}

zpm_update_one() {
  local spec="$1"
  zpm_parse_spec "$spec"
  if [[ "$ZPM_SPEC_TYPE" == "local" ]]; then
    zpm_info "Skipping local plugin (no update): ${ZPM_SPEC_PATH}"
    return 0
  fi
  local dest
  dest="$(zpm_repo_path "${ZPM_SPEC_HOST:-unknown}" "${ZPM_SPEC_OWNER:-unknown}" "${ZPM_SPEC_NAME:-unknown}")"
  if [[ ! -d "$dest" ]]; then
    zpm_info "Not installed, installing: ${ZPM_SPEC_OWNER}/${ZPM_SPEC_NAME}"
    zpm_install_one "$spec"
    return 0
  fi
  zpm_with_lock "${ZPM_SPEC_HOST}-${ZPM_SPEC_OWNER}-${ZPM_SPEC_NAME}" -- \
    zpm_update_repo "$dest" "${ZPM_SPEC_REF:-}"
  zpm_info "Updated: ${ZPM_SPEC_OWNER}/${ZPM_SPEC_NAME}${ZPM_SPEC_REF:+@$ZPM_SPEC_REF}"
}

zpm_list_installed() {
  if [[ ! -d "$ZPM_REPOS_DIR" ]]; then return 0; fi
  find "$ZPM_REPOS_DIR" -mindepth 3 -maxdepth 3 -type d -print 2>/dev/null | while read -r d; do
    local rel=${d#"${ZPM_REPOS_DIR}/"}
    echo "$rel"
  done
}

zpm_plugins_from_file() {
  local file="$1"
  [[ -f "$file" ]] || die "Plugins file not found: $file"
  # strip comments and blank lines
  sed -e 's/#.*$//' -e '/^\s*$/d' "$file"
}
