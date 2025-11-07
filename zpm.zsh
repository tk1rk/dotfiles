#!/usr/bin/env zsh
# ZPM - Ultra-Fast Zsh Plugin Manager
# A cutting-edge, high-performance plugin manager with robust error handling
# Version: 1.0.0

# Global configuration
typeset -g ZPM_DIR="${ZPM_DIR:-${ZDOTDIR:-$HOME}/.zpm}"
typeset -g ZPM_PLUGINS_DIR="${ZPM_DIR}/plugins"
typeset -g ZPM_CACHE_DIR="${ZPM_DIR}/cache"
typeset -g ZPM_LOG_FILE="${ZPM_DIR}/zpm.log"
typeset -g ZPM_MAX_JOBS=10
typeset -gA ZPM_PLUGINS
typeset -gA ZPM_PLUGIN_CONFIGS
typeset -g ZPM_VERBOSE=0
typeset -g ZPM_INITIALIZED=0

# Color codes for pretty output
typeset -g ZPM_COLOR_RESET=$'\e[0m'
typeset -g ZPM_COLOR_RED=$'\e[31m'
typeset -g ZPM_COLOR_GREEN=$'\e[32m'
typeset -g ZPM_COLOR_YELLOW=$'\e[33m'
typeset -g ZPM_COLOR_BLUE=$'\e[34m'
typeset -g ZPM_COLOR_MAGENTA=$'\e[35m'
typeset -g ZPM_COLOR_CYAN=$'\e[36m'
typeset -g ZPM_COLOR_BOLD=$'\e[1m'

#
# Utility Functions
#

# Log message to file
_zpm_log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*" >> "$ZPM_LOG_FILE"
}

# Print colored message
_zpm_msg() {
    local color="$1"
    shift
    echo "${color}${*}${ZPM_COLOR_RESET}"
}

# Print error message
_zpm_error() {
    _zpm_msg "$ZPM_COLOR_RED" "✗ Error: $*" >&2
    _zpm_log "ERROR" "$*"
    return 1
}

# Print success message
_zpm_success() {
    _zpm_msg "$ZPM_COLOR_GREEN" "✓ $*"
    _zpm_log "INFO" "$*"
}

# Print info message
_zpm_info() {
    _zpm_msg "$ZPM_COLOR_BLUE" "➜ $*"
    [[ $ZPM_VERBOSE -eq 1 ]] && _zpm_log "INFO" "$*"
}

# Print warning message
_zpm_warn() {
    _zpm_msg "$ZPM_COLOR_YELLOW" "⚠ Warning: $*"
    _zpm_log "WARN" "$*"
}

# Safe directory creation with error handling
_zpm_mkdir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        if ! mkdir -p "$dir" 2>/dev/null; then
            _zpm_error "Failed to create directory: $dir"
            return 1
        fi
    fi
    return 0
}

# Parse plugin URL and extract name
_zpm_parse_plugin() {
    local plugin="$1"
    local name url branch
    
    # Handle different formats:
    # - user/repo
    # - https://github.com/user/repo
    # - user/repo@branch
    # - https://github.com/user/repo@branch
    
    if [[ "$plugin" =~ ^https?:// ]]; then
        # Full URL
        url="${plugin%%@*}"
        branch="${plugin##*@}"
        [[ "$branch" == "$plugin" ]] && branch="main"
        name="${${url##*/}%.git}"
    elif [[ "$plugin" =~ ^[a-zA-Z0-9_-]+/[a-zA-Z0-9_.-]+(@[a-zA-Z0-9_-]+)?$ ]]; then
        # GitHub shorthand
        branch="${plugin##*@}"
        [[ "$branch" == "$plugin" ]] && branch="main"
        plugin="${plugin%%@*}"
        url="https://github.com/${plugin}.git"
        name="${plugin##*/}"
    else
        _zpm_error "Invalid plugin format: $plugin"
        return 1
    fi
    
    echo "$name|$url|$branch"
    return 0
}

# Check if command exists
_zpm_has_command() {
    command -v "$1" &>/dev/null
}

# Validate dependencies
_zpm_check_deps() {
    local missing=()
    
    for cmd in git zsh; do
        if ! _zpm_has_command "$cmd"; then
            missing+=("$cmd")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        _zpm_error "Missing required dependencies: ${missing[*]}"
        return 1
    fi
    
    return 0
}

#
# Core Plugin Management Functions
#

# Initialize ZPM
zpm_init() {
    [[ $ZPM_INITIALIZED -eq 1 ]] && return 0
    
    # Check dependencies
    _zpm_check_deps || return 1
    
    # Create necessary directories
    _zpm_mkdir "$ZPM_DIR" || return 1
    _zpm_mkdir "$ZPM_PLUGINS_DIR" || return 1
    _zpm_mkdir "$ZPM_CACHE_DIR" || return 1
    
    # Initialize log file
    if [[ ! -f "$ZPM_LOG_FILE" ]]; then
        touch "$ZPM_LOG_FILE" 2>/dev/null || {
            _zpm_error "Failed to create log file: $ZPM_LOG_FILE"
            return 1
        }
    fi
    
    _zpm_log "INFO" "ZPM initialized"
    ZPM_INITIALIZED=1
    return 0
}

# Clone a plugin repository
_zpm_clone_plugin() {
    local name="$1"
    local url="$2"
    local branch="${3:-main}"
    local plugin_dir="$ZPM_PLUGINS_DIR/$name"
    
    if [[ -d "$plugin_dir" ]]; then
        _zpm_warn "Plugin '$name' already exists"
        return 0
    fi
    
    _zpm_info "Cloning $name from $url (branch: $branch)..."
    
    # Use git clone with depth=1 for speed and error handling
    local clone_output
    if clone_output=$(git clone --depth=1 --branch="$branch" --single-branch \
        "$url" "$plugin_dir" 2>&1); then
        _zpm_success "Installed $name"
        return 0
    else
        # Try without branch if it fails (fallback to default)
        if [[ "$branch" != "main" && "$branch" != "master" ]]; then
            _zpm_warn "Branch '$branch' not found, trying default branch..."
            if clone_output=$(git clone --depth=1 --single-branch \
                "$url" "$plugin_dir" 2>&1); then
                _zpm_success "Installed $name"
                return 0
            fi
        fi
        
        _zpm_error "Failed to clone $name: ${clone_output}"
        [[ -d "$plugin_dir" ]] && rm -rf "$plugin_dir"
        return 1
    fi
}

# Install a plugin
zpm_install() {
    [[ $# -eq 0 ]] && {
        _zpm_error "Usage: zpm_install <plugin> [plugin...]"
        return 1
    }
    
    zpm_init || return 1
    
    local plugins=("$@")
    local -a jobs
    local max_jobs=$ZPM_MAX_JOBS
    local failed=0
    
    _zpm_info "Installing ${#plugins[@]} plugin(s)..."
    
    # Process plugins in parallel (with job limit)
    for plugin in "${plugins[@]}"; do
        local parsed
        parsed=$(_zpm_parse_plugin "$plugin") || {
            ((failed++))
            continue
        }
        
        local name url branch
        IFS='|' read -r name url branch <<< "$parsed"
        
        # Wait if we've hit max jobs
        while [[ $(jobs -r | wc -l) -ge $max_jobs ]]; do
            sleep 0.1
        done
        
        # Clone in background
        (
            _zpm_clone_plugin "$name" "$url" "$branch"
        ) &
        jobs+=($!)
    done
    
    # Wait for all jobs to complete
    for job in "${jobs[@]}"; do
        wait "$job" || ((failed++))
    done
    
    if [[ $failed -eq 0 ]]; then
        _zpm_success "All plugins installed successfully"
        return 0
    else
        _zpm_warn "$failed plugin(s) failed to install"
        return 1
    fi
}

# Load a single plugin
_zpm_load_plugin() {
    local name="$1"
    local plugin_dir="$ZPM_PLUGINS_DIR/$name"
    
    if [[ ! -d "$plugin_dir" ]]; then
        _zpm_error "Plugin '$name' not found in $plugin_dir"
        return 1
    fi
    
    # Try to find the main plugin file
    local plugin_file
    local possible_files=(
        "$plugin_dir/$name.plugin.zsh"
        "$plugin_dir/$name.zsh"
        "$plugin_dir/init.zsh"
        "$plugin_dir/$name.sh"
    )
    
    for file in "${possible_files[@]}"; do
        if [[ -f "$file" ]]; then
            plugin_file="$file"
            break
        fi
    done
    
    # If no standard file found, source the first .zsh file
    if [[ -z "$plugin_file" ]]; then
        plugin_file=$(find "$plugin_dir" -maxdepth 2 -name "*.zsh" -type f 2>/dev/null | head -n 1)
    fi
    
    if [[ -z "$plugin_file" || ! -f "$plugin_file" ]]; then
        _zpm_error "No loadable file found for plugin '$name'"
        return 1
    fi
    
    # Add to fpath if needed
    if [[ -d "$plugin_dir/functions" ]]; then
        fpath=("$plugin_dir/functions" $fpath)
    fi
    
    # Source the plugin
    if source "$plugin_file" 2>/dev/null; then
        ZPM_PLUGINS[$name]="$plugin_file"
        [[ $ZPM_VERBOSE -eq 1 ]] && _zpm_success "Loaded $name"
        return 0
    else
        _zpm_error "Failed to source plugin '$name' from $plugin_file"
        return 1
    fi
}

# Load plugins
zpm_load() {
    [[ $# -eq 0 ]] && {
        _zpm_error "Usage: zpm_load <plugin> [plugin...]"
        return 1
    }
    
    zpm_init || return 1
    
    local failed=0
    for plugin in "$@"; do
        local name="${plugin##*/}"
        name="${name%%@*}"
        _zpm_load_plugin "$name" || ((failed++))
    done
    
    [[ $failed -eq 0 ]] && return 0 || return 1
}

# Update a single plugin
_zpm_update_plugin() {
    local name="$1"
    local plugin_dir="$ZPM_PLUGINS_DIR/$name"
    
    if [[ ! -d "$plugin_dir" ]]; then
        _zpm_error "Plugin '$name' not installed"
        return 1
    fi
    
    if [[ ! -d "$plugin_dir/.git" ]]; then
        _zpm_error "Plugin '$name' is not a git repository"
        return 1
    fi
    
    _zpm_info "Updating $name..."
    
    local update_output
    if update_output=$(cd "$plugin_dir" && git pull --rebase --autostash 2>&1); then
        if [[ "$update_output" == *"Already up to date"* ]]; then
            _zpm_info "$name is already up to date"
        else
            _zpm_success "Updated $name"
        fi
        return 0
    else
        _zpm_error "Failed to update $name: ${update_output}"
        return 1
    fi
}

# Update plugins
zpm_update() {
    zpm_init || return 1
    
    local plugins=("$@")
    
    # If no plugins specified, update all
    if [[ ${#plugins[@]} -eq 0 ]]; then
        plugins=("$ZPM_PLUGINS_DIR"/*(N:t))
        [[ ${#plugins[@]} -eq 0 ]] && {
            _zpm_warn "No plugins installed"
            return 0
        }
    fi
    
    _zpm_info "Updating ${#plugins[@]} plugin(s)..."
    
    local -a jobs
    local max_jobs=$ZPM_MAX_JOBS
    local failed=0
    
    # Process updates in parallel
    for plugin in "${plugins[@]}"; do
        local name="${plugin##*/}"
        name="${name%%@*}"
        
        # Wait if we've hit max jobs
        while [[ $(jobs -r | wc -l) -ge $max_jobs ]]; do
            sleep 0.1
        done
        
        # Update in background
        (
            _zpm_update_plugin "$name"
        ) &
        jobs+=($!)
    done
    
    # Wait for all jobs to complete
    for job in "${jobs[@]}"; do
        wait "$job" || ((failed++))
    done
    
    if [[ $failed -eq 0 ]]; then
        _zpm_success "All plugins updated successfully"
        return 0
    else
        _zpm_warn "$failed plugin(s) failed to update"
        return 1
    fi
}

# Remove a plugin
zpm_remove() {
    [[ $# -eq 0 ]] && {
        _zpm_error "Usage: zpm_remove <plugin> [plugin...]"
        return 1
    }
    
    zpm_init || return 1
    
    local failed=0
    for plugin in "$@"; do
        local name="${plugin##*/}"
        name="${name%%@*}"
        local plugin_dir="$ZPM_PLUGINS_DIR/$name"
        
        if [[ ! -d "$plugin_dir" ]]; then
            _zpm_warn "Plugin '$name' not found"
            ((failed++))
            continue
        fi
        
        _zpm_info "Removing $name..."
        if rm -rf "$plugin_dir"; then
            unset "ZPM_PLUGINS[$name]"
            _zpm_success "Removed $name"
        else
            _zpm_error "Failed to remove $name"
            ((failed++))
        fi
    done
    
    [[ $failed -eq 0 ]] && return 0 || return 1
}

# List installed plugins
zpm_list() {
    zpm_init || return 1
    
    local plugins=("$ZPM_PLUGINS_DIR"/*(N:t))
    
    if [[ ${#plugins[@]} -eq 0 ]]; then
        _zpm_info "No plugins installed"
        return 0
    fi
    
    _zpm_msg "$ZPM_COLOR_BOLD" "Installed Plugins:"
    echo
    
    for plugin in "${plugins[@]}"; do
        local plugin_dir="$ZPM_PLUGINS_DIR/$plugin"
        local status="${ZPM_COLOR_GREEN}✓${ZPM_COLOR_RESET}"
        local info=""
        
        # Check if loaded
        if [[ -n "${ZPM_PLUGINS[$plugin]}" ]]; then
            status="${ZPM_COLOR_GREEN}● loaded${ZPM_COLOR_RESET}"
        else
            status="${ZPM_COLOR_YELLOW}○ not loaded${ZPM_COLOR_RESET}"
        fi
        
        # Get git info
        if [[ -d "$plugin_dir/.git" ]]; then
            local branch=$(cd "$plugin_dir" && git branch --show-current 2>/dev/null)
            local commit=$(cd "$plugin_dir" && git rev-parse --short HEAD 2>/dev/null)
            info=" ${ZPM_COLOR_CYAN}[$branch@$commit]${ZPM_COLOR_RESET}"
        fi
        
        echo "  $status  ${ZPM_COLOR_BOLD}$plugin${ZPM_COLOR_RESET}$info"
    done
    
    echo
    _zpm_info "Total: ${#plugins[@]} plugin(s)"
    return 0
}

# Clean cache and unused files
zpm_clean() {
    zpm_init || return 1
    
    _zpm_info "Cleaning ZPM cache..."
    
    if [[ -d "$ZPM_CACHE_DIR" ]]; then
        rm -rf "$ZPM_CACHE_DIR"/*
        _zpm_success "Cache cleaned"
    fi
    
    # Clean git repositories
    local plugins=("$ZPM_PLUGINS_DIR"/*(N:t))
    for plugin in "${plugins[@]}"; do
        local plugin_dir="$ZPM_PLUGINS_DIR/$plugin"
        if [[ -d "$plugin_dir/.git" ]]; then
            _zpm_info "Cleaning $plugin git repository..."
            (cd "$plugin_dir" && git gc --quiet 2>/dev/null)
        fi
    done
    
    _zpm_success "All plugins cleaned"
    return 0
}

# Show ZPM status and info
zpm_status() {
    zpm_init || return 1
    
    _zpm_msg "$ZPM_COLOR_BOLD" "ZPM Status"
    echo
    echo "  ${ZPM_COLOR_CYAN}Directory:${ZPM_COLOR_RESET}     $ZPM_DIR"
    echo "  ${ZPM_COLOR_CYAN}Plugins Dir:${ZPM_COLOR_RESET}   $ZPM_PLUGINS_DIR"
    echo "  ${ZPM_COLOR_CYAN}Cache Dir:${ZPM_COLOR_RESET}     $ZPM_CACHE_DIR"
    echo "  ${ZPM_COLOR_CYAN}Log File:${ZPM_COLOR_RESET}      $ZPM_LOG_FILE"
    echo "  ${ZPM_COLOR_CYAN}Max Jobs:${ZPM_COLOR_RESET}      $ZPM_MAX_JOBS"
    echo
    
    local plugins=("$ZPM_PLUGINS_DIR"/*(N:t))
    echo "  ${ZPM_COLOR_CYAN}Installed:${ZPM_COLOR_RESET}     ${#plugins[@]} plugin(s)"
    echo "  ${ZPM_COLOR_CYAN}Loaded:${ZPM_COLOR_RESET}        ${#ZPM_PLUGINS[@]} plugin(s)"
    echo
    
    return 0
}

# Main ZPM command dispatcher
zpm() {
    local cmd="${1:-help}"
    shift
    
    case "$cmd" in
        install|i)
            zpm_install "$@"
            ;;
        load|l)
            zpm_load "$@"
            ;;
        update|u)
            zpm_update "$@"
            ;;
        remove|rm|delete)
            zpm_remove "$@"
            ;;
        list|ls)
            zpm_list "$@"
            ;;
        clean)
            zpm_clean "$@"
            ;;
        status|info)
            zpm_status "$@"
            ;;
        init)
            zpm_init
            ;;
        help|--help|-h)
            cat << 'EOF'
ZPM - Ultra-Fast Zsh Plugin Manager

Usage: zpm <command> [options]

Commands:
  install, i <plugin...>    Install one or more plugins
  load, l <plugin...>       Load one or more plugins
  update, u [plugin...]     Update plugins (all if none specified)
  remove, rm <plugin...>    Remove one or more plugins
  list, ls                  List installed plugins
  clean                     Clean cache and optimize repositories
  status, info              Show ZPM status and configuration
  init                      Initialize ZPM (auto-run on first use)
  help                      Show this help message

Plugin Format:
  - GitHub shorthand:   user/repo[@branch]
  - Full URL:           https://github.com/user/repo[@branch]

Examples:
  zpm install zsh-users/zsh-autosuggestions
  zpm install zdharma/fast-syntax-highlighting@main
  zpm load zsh-autosuggestions fast-syntax-highlighting
  zpm update
  zpm list

Environment Variables:
  ZPM_DIR              ZPM installation directory (default: ~/.zpm)
  ZPM_MAX_JOBS         Maximum parallel jobs (default: 10)
  ZPM_VERBOSE          Verbose output (0 or 1)

For more information, visit: https://github.com/yourusername/zpm
EOF
            ;;
        *)
            _zpm_error "Unknown command: $cmd"
            echo "Run 'zpm help' for usage information"
            return 1
            ;;
    esac
}

# Lazy loading wrapper for performance
zpm_lazy_load() {
    local plugin="$1"
    shift
    local commands=("$@")
    
    if [[ ${#commands[@]} -eq 0 ]]; then
        _zpm_error "Usage: zpm_lazy_load <plugin> <command...>"
        return 1
    fi
    
    for cmd in "${commands[@]}"; do
        eval "
        $cmd() {
            unfunction $cmd 2>/dev/null
            zpm_load $plugin
            command $cmd \"\$@\"
        }
        "
    done
}

# Auto-initialization
zpm_init

# Export main functions
typeset -gx zpm zpm_install zpm_load zpm_update zpm_remove zpm_list zpm_clean zpm_status zpm_lazy_load
