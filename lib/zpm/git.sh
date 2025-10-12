#!/usr/bin/env bash
# shellcheck shell=bash

# Git and tarball fallback operations

zpm_git_available() { is_command git; }

zpm_clone_shallow() {
  # url dest [ref]
  local url="$1" dest="$2" ref="${3:-}"
  if zpm_git_available; then
    local args=(clone --filter=blob:none --depth 1 --recurse-submodules --shallow-submodules)
    if [[ -n "$ref" ]]; then
      # We try as branch/tag. If not, we handle after clone.
      args+=(--branch "$ref" --single-branch)
    fi
    args+=("$url" "$dest")
    if ! git "${args[@]}" 2>/dev/null; then
      # Fallback: clone default branch shallow, then checkout ref
      git clone --filter=blob:none --depth 1 "$url" "$dest"
      if [[ -n "$ref" ]]; then
        ( cd "$dest" && git fetch --depth 1 origin "$ref" && git checkout --detach FETCH_HEAD ) || true
      fi
    fi
    return 0
  fi
  zpm_info "git not found; attempting tarball download"
  zpm_fetch_tarball "$url" "$dest" "$ref"
}

zpm_update_repo() {
  # dest [ref]
  local dest="$1" ref="${2:-}"
  if [[ -d "$dest/.git" ]] && zpm_git_available; then
    (
      cd "$dest"
      git remote set-url origin "$(git remote get-url origin | sed 's/\n//g')" || true
      git fetch --depth 1 --tags --prune origin
      if [[ -n "$ref" ]]; then
        if git rev-parse --verify --quiet "$ref" >/dev/null; then
          git checkout --detach "$ref" || true
        else
          git checkout -B "$ref" "origin/${ref}" 2>/dev/null || git checkout --detach "origin/${ref}" || true
        fi
      else
        local default_branch
        default_branch=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@')
        default_branch=${default_branch:-main}
        git checkout -B "$default_branch" "origin/${default_branch}" || true
      fi
      git submodule update --init --depth 1 --recursive || true
    )
    return 0
  fi
  zpm_info "Non-git repo; re-fetching via tarball"
  rm -rf "$dest" && mkdir -p "$dest"
  zpm_fetch_tarball "$(zpm_guess_origin_url_from_path "$dest")" "$dest" "$ref"
}

zpm_guess_origin_url_from_path() {
  # Best-effort: derive url when repo is at ZPM_REPOS_DIR/host/owner/name
  local dest="$1"
  local rel=${dest#"${ZPM_REPOS_DIR}/"}
  local host=${rel%%/*}
  local rest=${rel#*/}
  local owner=${rest%%/*}
  local name=${rest#*/}
  echo "https://${host}/${owner}/${name}.git"
}

zpm_fetch_tarball() {
  # url dest [ref]
  local url="$1" dest="$2" ref="${3:-}"
  require_cmd curl
  require_cmd tar
  # Only GitHub supported for fallback (common case)
  local gh_pat='^https?://(www\.)?github\.com/([^/]+)/([^/.]+)(\.git)?'
  if [[ "$url" =~ $gh_pat ]]; then
    local owner="${BASH_REMATCH[2]}" name="${BASH_REMATCH[3]}"
    local ref_or_default="${ref:-}"
    if [[ -z "$ref_or_default" ]]; then
      # Try to get default branch
      if curl -fsSL "https://api.github.com/repos/${owner}/${name}" | grep -q 'default_branch'; then
        ref_or_default=$(curl -fsSL "https://api.github.com/repos/${owner}/${name}" | sed -n 's/.*"default_branch": "\([^"]\+\)".*/\1/p' | head -n1)
      else
        ref_or_default=main
      fi
    fi
    local tmp
    tmp="$(mktempdir)"
    local tarball_url="https://codeload.github.com/${owner}/${name}/tar.gz/${ref_or_default}"
    zpm_debug "Downloading tarball ${tarball_url}"
    curl -fsSL "$tarball_url" -o "${tmp}/repo.tgz"
    mkdir -p "$dest"
    tar -xzf "${tmp}/repo.tgz" -C "$tmp"
    local extracted
    extracted="$(find "$tmp" -maxdepth 1 -type d -name "${name}-*" | head -n1)"
    if [[ -z "$extracted" ]]; then
      die "Failed to extract tarball for ${owner}/${name}"
    fi
    rm -rf "$dest" && mkdir -p "$(dirname "$dest")"
    mv "$extracted" "$dest"
    return 0
  fi
  die "Tarball fallback currently supports github.com only (url: $url)"
}
