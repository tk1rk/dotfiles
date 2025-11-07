#!/usr/bin/env bash
# shellcheck shell=bash

# Lock helpers: use flock when available, otherwise mkdir-based lock

zpm_with_lock() {
  # Usage: zpm_with_lock <name> -- <command> [args...]
  local name="$1"; shift
  if [[ "$1" != "--" ]]; then
    die "zpm_with_lock requires -- separator"
  fi
  shift
  local lockf="${ZPM_LOCKS_DIR}/${name}.lock"
  mkdir -p "${ZPM_LOCKS_DIR}" || true
  if is_command flock; then
    # flock path
    local fd
    exec {fd}>"$lockf"
    if ! flock -w "${ZPM_LOCK_TIMEOUT}" "$fd"; then
      die "Failed to acquire lock: ${name} within ${ZPM_LOCK_TIMEOUT}s"
    fi
    "$@"
    # Release
    flock -u "$fd" || true
    eval "exec ${fd}>&-" || true
  else
    # mkdir lock fallback
    local acquired=0
    local start="$(date +%s)"
    while true; do
      if mkdir "$lockf" 2>/dev/null; then
        acquired=1; break
      fi
      sleep 0.2
      local now="$(date +%s)"
      if (( now - start >= ZPM_LOCK_TIMEOUT )); then
        break
      fi
    done
    if (( acquired == 0 )); then
      die "Failed to acquire lock: ${name} within ${ZPM_LOCK_TIMEOUT}s"
    fi
    local rc=0
    "$@" || rc=$?
    rmdir "$lockf" 2>/dev/null || true
    return $rc
  fi
}
