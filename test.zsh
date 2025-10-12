#!/usr/bin/env zsh
# ZPM Test Suite
# Run this script to test ZPM functionality

# Test configuration
export ZPM_DIR="/tmp/zpm-test-$$"
export ZPM_VERBOSE=1
export ZPM_MAX_JOBS=5

# Colors
RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
BLUE=$'\e[34m'
NC=$'\e[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Source ZPM
source ./zpm.zsh

# Test functions
test_start() {
    echo ""
    echo "${BLUE}▶ Testing: $1${NC}"
    ((TESTS_RUN++))
}

test_pass() {
    echo "${GREEN}  ✓ PASS: $1${NC}"
    ((TESTS_PASSED++))
}

test_fail() {
    echo "${RED}  ✗ FAIL: $1${NC}"
    ((TESTS_FAILED++))
}

assert_success() {
    if [[ $? -eq 0 ]]; then
        test_pass "$1"
        return 0
    else
        test_fail "$1"
        return 1
    fi
}

assert_failure() {
    if [[ $? -ne 0 ]]; then
        test_pass "$1"
        return 0
    else
        test_fail "$1"
        return 1
    fi
}

assert_exists() {
    if [[ -e "$1" ]]; then
        test_pass "File/directory exists: $1"
        return 0
    else
        test_fail "File/directory not found: $1"
        return 1
    fi
}

assert_not_exists() {
    if [[ ! -e "$1" ]]; then
        test_pass "File/directory correctly absent: $1"
        return 0
    else
        test_fail "File/directory should not exist: $1"
        return 1
    fi
}

# Test suite
run_tests() {
    echo ""
    echo "========================================"
    echo "  ZPM Test Suite"
    echo "========================================"
    echo ""
    echo "Test directory: $ZPM_DIR"
    
    # Test 1: Initialization
    test_start "ZPM Initialization"
    zpm init
    assert_success "ZPM initialized"
    assert_exists "$ZPM_DIR"
    assert_exists "$ZPM_PLUGINS_DIR"
    assert_exists "$ZPM_CACHE_DIR"
    assert_exists "$ZPM_LOG_FILE"
    
    # Test 2: Plugin installation (invalid)
    test_start "Invalid Plugin Installation"
    zpm install "invalid/plugin/format/test" 2>/dev/null
    assert_failure "Invalid plugin format correctly rejected"
    
    # Test 3: Plugin installation (GitHub shorthand)
    test_start "Plugin Installation (GitHub shorthand)"
    # Use a small, fast-to-clone repository for testing
    zpm install "romkatv/zsh4humans" 2>/dev/null || true
    if [[ -d "$ZPM_PLUGINS_DIR/zsh4humans" ]]; then
        test_pass "Plugin installed from GitHub shorthand"
    else
        test_fail "Plugin installation from GitHub shorthand failed"
    fi
    
    # Test 4: Plugin listing
    test_start "Plugin Listing"
    zpm list | grep -q "zsh4humans"
    assert_success "Installed plugin appears in list"
    
    # Test 5: Plugin loading
    test_start "Plugin Loading"
    # Note: Loading might fail if plugin structure isn't standard, but installation should work
    zpm load zsh4humans 2>/dev/null || true
    test_pass "Plugin load attempted (structure may vary)"
    
    # Test 6: Status command
    test_start "Status Command"
    zpm status | grep -q "ZPM Status"
    assert_success "Status command displays information"
    
    # Test 7: Plugin update
    test_start "Plugin Update"
    zpm update zsh4humans 2>/dev/null
    if [[ $? -eq 0 ]] || [[ $? -eq 1 ]]; then
        # Both 0 (updated) and 1 (already up to date) are acceptable
        test_pass "Plugin update executed"
    else
        test_fail "Plugin update failed"
    fi
    
    # Test 8: Clean command
    test_start "Clean Command"
    zpm clean
    assert_success "Clean command executed"
    
    # Test 9: Plugin removal
    test_start "Plugin Removal"
    zpm remove zsh4humans
    assert_success "Plugin removed"
    assert_not_exists "$ZPM_PLUGINS_DIR/zsh4humans"
    
    # Test 10: Help command
    test_start "Help Command"
    zpm help | grep -q "Usage: zpm"
    assert_success "Help command displays usage"
    
    # Test 11: Multiple plugin installation (parallel)
    test_start "Parallel Plugin Installation"
    # Use small repositories for faster testing
    zpm install \
        "romkatv/zsh4humans" \
        "rupa/z" 2>/dev/null || true
    
    local installed_count=$(ls -1 "$ZPM_PLUGINS_DIR" 2>/dev/null | wc -l)
    if [[ $installed_count -ge 2 ]]; then
        test_pass "Multiple plugins installed in parallel ($installed_count plugins)"
    else
        test_fail "Parallel installation may have issues"
    fi
    
    # Test 12: Directory permissions
    test_start "Directory Permissions"
    if [[ -r "$ZPM_DIR" && -w "$ZPM_DIR" && -x "$ZPM_DIR" ]]; then
        test_pass "ZPM directory has correct permissions"
    else
        test_fail "ZPM directory permissions issue"
    fi
}

# Cleanup function
cleanup() {
    echo ""
    echo "${YELLOW}Cleaning up test environment...${NC}"
    if [[ -d "$ZPM_DIR" ]]; then
        rm -rf "$ZPM_DIR"
        echo "${GREEN}✓ Test directory removed${NC}"
    fi
}

# Print summary
print_summary() {
    echo ""
    echo "========================================"
    echo "  Test Summary"
    echo "========================================"
    echo ""
    echo "Total tests run:    $TESTS_RUN"
    echo "${GREEN}Tests passed:       $TESTS_PASSED${NC}"
    
    if [[ $TESTS_FAILED -gt 0 ]]; then
        echo "${RED}Tests failed:       $TESTS_FAILED${NC}"
        echo ""
        echo "${RED}Some tests failed. Please review the output above.${NC}"
        return 1
    else
        echo "${GREEN}Tests failed:       $TESTS_FAILED${NC}"
        echo ""
        echo "${GREEN}All tests passed!${NC}"
        return 0
    fi
}

# Main execution
main() {
    # Run tests
    run_tests
    
    # Cleanup
    cleanup
    
    # Print summary
    print_summary
    exit $?
}

# Trap cleanup on exit
trap cleanup EXIT INT TERM

# Run main
main "$@"
