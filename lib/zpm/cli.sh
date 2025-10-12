#!/usr/bin/env bash
# shellcheck shell=bash

# CLI dispatch for zpm

zpm_usage() {
  cat <<'USAGE'
Usage: zpm <command> [options]

Commands:
  help                     Show this help
  version                  Show version
  path                     Show zpm home directory
  doctor                   Check environment and dependencies
  install [SPEC ...]       Install plugins (from args or plugins file)
  update  [SPEC ...]       Update plugins (from args or plugins file)
  list                     List installed plugins
  init                     Print snippet to add to .zshrc

Environment:
  ZPM_HOME, ZPM_REPOS_DIR, ZPM_LOCKS_DIR, ZPM_PLUGINS_FILE, ZPM_JOBS, ZPM_COLOR

Examples:
  zpm install zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting
  zpm update
  zpm init >> ~/.zshrc
USAGE
}

zpm_cmd_version() { echo "zpm ${ZPM_VERSION}"; }

zpm_cmd_path() { echo "${ZPM_HOME}"; }

zpm_cmd_doctor() {
  local ok=1
  for c in bash curl tar; do
    if ! is_command "$c"; then zpm_warn "Missing: $c"; ok=0; else zpm_info "Found: $c"; fi
  done
  if is_command git; then zpm_info "Found: git"; else zpm_warn "git not found (tarball fallback for GitHub only)"; fi
  if is_command zsh; then zpm_info "Found: zsh"; else zpm_warn "zsh not found (loading in shell will be limited)"; fi
  [[ $ok -eq 1 ]] || return 1
}

zpm_cmd_install() {
  shift || true # shift off subcommand name from caller
  local specs=()
  if [[ $# -gt 0 ]]; then
    specs=("$@")
  else
    if [[ -f "$ZPM_PLUGINS_FILE" ]]; then
      mapfile -t specs < <(zpm_plugins_from_file "$ZPM_PLUGINS_FILE")
    else
      die "No specs given and plugins file not found: ${ZPM_PLUGINS_FILE}"
    fi
  fi
  if [[ ${#specs[@]} -eq 0 ]]; then
    zpm_info "Nothing to install"
    return 0
  fi
  zpm_info "Installing ${#specs[@]} plugin(s) with concurrency ${ZPM_JOBS}"
  zpm_parallel_each "${ZPM_JOBS}" zpm_install_one "${specs[@]}"
}

zpm_cmd_update() {
  shift || true
  local specs=()
  if [[ $# -gt 0 ]]; then
    specs=("$@")
  else
    # Build specs from installed layout
    while IFS= read -r rel; do
      local host owner name
      host="${rel%%/*}"; local tmp=${rel#*/}; owner="${tmp%%/*}"; name="${tmp#*/}"
      specs+=("https://${host}/${owner}/${name}.git")
    done < <(zpm_list_installed)
  fi
  if [[ ${#specs[@]} -eq 0 ]]; then
    zpm_info "Nothing to update"
    return 0
  fi
  zpm_info "Updating ${#specs[@]} plugin(s) with concurrency ${ZPM_JOBS}"
  zpm_parallel_each "${ZPM_JOBS}" zpm_update_one "${specs[@]}"
}

zpm_cmd_list() {
  zpm_list_installed
}

zpm_cmd_init() {
  cat <<'INIT'
# zpm init - add this to your .zshrc
# Load plugins installed under ZPM_HOME
if [[ -z "$ZPM_HOME" ]]; then
  if [[ -n "$XDG_CACHE_HOME" ]]; then ZPM_HOME="$XDG_CACHE_HOME/zpm"; else ZPM_HOME="$HOME/.cache/zpm"; fi
fi
if [[ -d "$ZPM_HOME/repos" ]]; then
  # Update fpath for functions directories
  for d in "$ZPM_HOME"/repos/*/*/*; do
    if [[ -d "$d" ]]; then
      [[ -d "$d/functions" ]] && fpath=("$d/functions" $fpath)
      # Source plugin entrypoints
      if [[ -f "$d/${PWD##*/}.plugin.zsh" ]]; then
        source "$d/${PWD##*/}.plugin.zsh"
      else
        for f in "$d"/*.plugin.zsh(N) "$d"/*.zsh(N); do
          [[ -f "$f" ]] && source "$f"
        done
      fi
    fi
  done
fi
unset d f
INIT
}

zpm_cli_dispatch() {
  local cmd="${1:-help}"
  case "$cmd" in
    help|-h|--help) zpm_usage ;;
    version|--version) zpm_cmd_version ;;
    path) zpm_cmd_path ;;
    doctor) zpm_cmd_doctor ;;
    install) zpm_cmd_install "$@" ;;
    update) zpm_cmd_update "$@" ;;
    list|ls) zpm_cmd_list ;;
    init) zpm_cmd_init ;;
    *) zpm_error "Unknown command: $cmd"; echo; zpm_usage; return 1 ;;
  esac
}
