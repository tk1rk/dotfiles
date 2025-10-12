#!/usr/bin/env bash
# ZPM Installation Script
# This script installs ZPM to your system

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ZPM_INSTALL_DIR="${ZPM_INSTALL_DIR:-$HOME/.zpm-source}"
ZPM_SCRIPT="zpm.zsh"
ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"

# Functions
print_info() {
    echo -e "${BLUE}➜${NC} $*"
}

print_success() {
    echo -e "${GREEN}✓${NC} $*"
}

print_error() {
    echo -e "${RED}✗${NC} $*" >&2
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $*"
}

check_requirements() {
    print_info "Checking requirements..."
    
    local missing=()
    
    if ! command -v zsh &>/dev/null; then
        missing+=("zsh")
    fi
    
    if ! command -v git &>/dev/null; then
        missing+=("git")
    fi
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        print_error "Missing required dependencies: ${missing[*]}"
        print_info "Please install them and try again."
        exit 1
    fi
    
    print_success "All requirements satisfied"
}

install_zpm() {
    print_info "Installing ZPM to $ZPM_INSTALL_DIR..."
    
    # Create installation directory
    if [[ ! -d "$ZPM_INSTALL_DIR" ]]; then
        mkdir -p "$ZPM_INSTALL_DIR" || {
            print_error "Failed to create directory: $ZPM_INSTALL_DIR"
            exit 1
        }
    fi
    
    # Copy ZPM script
    if [[ -f "$ZPM_SCRIPT" ]]; then
        cp "$ZPM_SCRIPT" "$ZPM_INSTALL_DIR/$ZPM_SCRIPT" || {
            print_error "Failed to copy ZPM script"
            exit 1
        }
        chmod +x "$ZPM_INSTALL_DIR/$ZPM_SCRIPT"
        print_success "ZPM installed to $ZPM_INSTALL_DIR/$ZPM_SCRIPT"
    else
        print_error "ZPM script not found: $ZPM_SCRIPT"
        exit 1
    fi
    
    # Copy example configuration if it exists
    if [[ -f "example.zshrc" ]]; then
        cp "example.zshrc" "$ZPM_INSTALL_DIR/example.zshrc"
        print_success "Example configuration copied"
    fi
}

configure_zshrc() {
    print_info "Configuring $ZSHRC..."
    
    local source_line="source $ZPM_INSTALL_DIR/$ZPM_SCRIPT"
    
    # Check if already configured
    if [[ -f "$ZSHRC" ]] && grep -qF "$source_line" "$ZSHRC"; then
        print_warning "ZPM already configured in $ZSHRC"
        return 0
    fi
    
    # Create backup
    if [[ -f "$ZSHRC" ]]; then
        cp "$ZSHRC" "${ZSHRC}.backup.$(date +%Y%m%d_%H%M%S)"
        print_success "Backed up existing .zshrc"
    fi
    
    # Add ZPM to .zshrc
    cat >> "$ZSHRC" << EOF

# ZPM - Ultra-Fast Zsh Plugin Manager
# Installed on $(date)
$source_line
EOF
    
    print_success "Added ZPM to $ZSHRC"
}

print_next_steps() {
    echo ""
    echo -e "${GREEN}${BOLD}Installation complete!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Reload your shell:"
    echo "     ${BLUE}source $ZSHRC${NC}"
    echo ""
    echo "  2. Install some plugins:"
    echo "     ${BLUE}zpm install zsh-users/zsh-autosuggestions${NC}"
    echo "     ${BLUE}zpm install zdharma-continuum/fast-syntax-highlighting${NC}"
    echo ""
    echo "  3. Load plugins (add to your .zshrc):"
    echo "     ${BLUE}zpm load zsh-autosuggestions${NC}"
    echo "     ${BLUE}zpm load fast-syntax-highlighting${NC}"
    echo ""
    echo "  4. View example configuration:"
    echo "     ${BLUE}cat $ZPM_INSTALL_DIR/example.zshrc${NC}"
    echo ""
    echo "For more information:"
    echo "  ${BLUE}zpm help${NC}"
    echo ""
}

# Main installation flow
main() {
    echo ""
    echo "======================================"
    echo "  ZPM Installation"
    echo "======================================"
    echo ""
    
    check_requirements
    install_zpm
    configure_zshrc
    print_next_steps
}

# Run main function
main "$@"
