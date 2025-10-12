#!/usr/bin/env bash
# shellcheck shell=bash

# Core environment, logging, and utility helpers for zpm

# Strict mode for robustness
set -Eeuo pipefail

# Defaults and directories
: "${XDG_CACHE_HOME:=${HOME}/.cache}"
: "${XDG_CONFIG_HOME:=${HOME}/.config}"
: "${ZPM_HOME:=${XDG_CACHE_HOME}/zpm}"
: "${ZPM_LOCKS_DIR:=${ZPM_HOME}/locks}"
: "${ZPM_REPOS_DIR:=${ZPM_HOME}/repos}"
: "${ZPM_PLUGINS_FILE:=${XDG_CONFIG_HOME}/zpm/plugins.txt}"
: "${ZPM_DEBUG:=}"
: "${ZPM_COLOR:=auto}"
: "${ZPM_LOG_TIME:=auto}"
: "${ZPM_LOCK_TIMEOUT:=60}"
: "${ZPM_JOBS:=}"

mkdir -p "${ZPM_HOME}" "${ZPM_LOCKS_DIR}" "${ZPM_REPOS_DIR}" || true

# Determine concurrency
if [[ -z "${ZPM_JOBS}" ]]; then
  if command -v nproc >/dev/null 2>&1; then
    ZPM_JOBS="$(nproc)"
  elif command -v sysctl >/dev/null 2>&1; then
    ZPM_JOBS="$(sysctl -n hw.ncpu 2>/dev/null || echo 4)"
  else
    ZPM_JOBS=4
  fi
fi
if ! [[ "${ZPM_JOBS}" =~ ^[0-9]+$ ]] || [[ "${ZPM_JOBS}" -lt 1 ]]; then
  ZPM_JOBS=4
fi

# Colors
_zpm_is_tty() { [[ -t 1 ]]; }
_zpm_use_color() {
  case "${ZPM_COLOR}" in
    always) return 0 ;;
    never) return 1 ;;
    auto|*) _zpm_is_tty ;;
  esac
}
if _zpm_use_color; then
  ZPM_CLR_RESET=$'\033[0m'
  ZPM_CLR_DIM=$'\033[2m'
  ZPM_CLR_RED=$'\033[31m'
  ZPM_CLR_GREEN=$'\033[32m'
  ZPM_CLR_YELLOW=$'\033[33m'
  ZPM_CLR_BLUE=$'\033[34m'
else
  ZPM_CLR_RESET=""; ZPM_CLR_DIM=""; ZPM_CLR_RED=""; ZPM_CLR_GREEN=""; ZPM_CLR_YELLOW=""; ZPM_CLR_BLUE=""
fi

# Timestamp toggle
_zpm_now() {
  if [[ "${ZPM_LOG_TIME}" == "always" ]] || { [[ "${ZPM_LOG_TIME}" == "auto" ]] && ! _zpm_is_tty; }; then
    date +"%H:%M:%S"
  else
    echo ""
  fi
}

# Logging
zpm_log() {
  local level="$1"; shift
  local color=""; local prefix="[$( _zpm_now )]"
  case "$level" in
    INFO) color="$ZPM_CLR_GREEN" ;;
    WARN) color="$ZPM_CLR_YELLOW" ;;
    ERROR) color="$ZPM_CLR_RED" ;;
    DEBUG) color="$ZPM_CLR_BLUE" ;;
    *) color="" ;;
  esac
  if [[ "$level" == "DEBUG" && -z "${ZPM_DEBUG}" ]]; then return 0; fi
  if [[ -n "$prefix" ]]; then prefix="${prefix} "; fi
  printf "%b%s%s%b %s%b\n" "$color" "$prefix" "$level" "$ZPM_CLR_RESET" "$*" "$ZPM_CLR_RESET" >&2
}

zpm_info() { zpm_log INFO "$@"; }
zpm_warn() { zpm_log WARN "$@"; }
zpm_error() { zpm_log ERROR "$@"; }
zpm_debug() { zpm_log DEBUG "$@"; }

die() { zpm_error "$*"; exit 1; }

# Command helpers
is_command() { command -v "$1" >/dev/null 2>&1; }
require_cmd() { is_command "$1" || die "Required command not found: $1"; }

# Temp directory helpers
_zpm_tmp_dirs=()
mktempdir() {
  local t
  t="$(mktemp -d 2>/dev/null || mktemp -d -t zpm)"
  _zpm_tmp_dirs+=("$t")
  echo "$t"
}

cleanup_tmpdirs() {
  local t
  for t in "${_zpm_tmp_dirs[@]:-}"; do
    [[ -n "$t" && -d "$t" ]] && rm -rf "$t" || true
  done
}

# Safe cleanup on exit and errors
trap cleanup_tmpdirs EXIT

# Concurrency helpers
_have_wait_n=1
if ! wait -n 2>/dev/null; then _have_wait_n=0; fi

zpm_parallel_each() {
  # Usage: zpm_parallel_each <concurrency> <function> <args...>
  local concurrency="$1"; shift
  local func="$1"; shift
  local -a pids=()
  local running=0
  local item
  if [[ "$concurrency" -lt 2 ]]; then
    for item in "$@"; do "$func" "$item"; done
    return 0
  fi
  for item in "$@"; do
    "$func" "$item" &
    pids+=("$!")
    running=$((running+1))
    if [[ $running -ge $concurrency ]]; then
      if [[ $_have_wait_n -eq 1 ]]; then
        wait -n || true
        running=$((running-1))
      else
        wait "${pids[0]}" || true
        pids=("${pids[@]:1}")
        running=$((running-1))
      fi
    fi
  done
  wait || true
}

# Path utils
zpm_repo_path() {
  # host owner name -> path
  local host="$1" owner="$2" name="$3"
  echo "${ZPM_REPOS_DIR}/${host}/${owner}/${name}"
}

# Version
ZPM_VERSION="0.1.0"
