#!/usr/bin/env bash
# ZPM Performance Benchmark
# Compare ZPM performance against other plugin managers

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Configuration
BENCHMARK_DIR="/tmp/zpm-benchmark-$$"
export ZPM_DIR="$BENCHMARK_DIR/zpm"

# Test plugins (small repositories for faster testing)
TEST_PLUGINS=(
    "rupa/z"
    "romkatv/zsh4humans"
)

# Utility functions
print_header() {
    echo ""
    echo -e "${BOLD}${CYAN}======================================${NC}"
    echo -e "${BOLD}${CYAN}  $1${NC}"
    echo -e "${BOLD}${CYAN}======================================${NC}"
    echo ""
}

print_info() {
    echo -e "${BLUE}➜${NC} $*"
}

print_success() {
    echo -e "${GREEN}✓${NC} $*"
}

print_result() {
    echo -e "${YELLOW}⚡${NC} $*"
}

# Timing function
time_operation() {
    local operation="$1"
    shift
    
    print_info "Timing: $operation"
    
    local start=$(date +%s.%N)
    "$@" &>/dev/null
    local end=$(date +%s.%N)
    
    local duration=$(echo "$end - $start" | bc)
    echo "$duration"
}

# Setup test environment
setup() {
    print_header "Setting Up Benchmark Environment"
    
    mkdir -p "$BENCHMARK_DIR"
    print_success "Created benchmark directory: $BENCHMARK_DIR"
    
    # Source ZPM
    source ./zpm.zsh
    print_success "Loaded ZPM"
}

# Cleanup
cleanup() {
    print_info "Cleaning up..."
    if [[ -d "$BENCHMARK_DIR" ]]; then
        rm -rf "$BENCHMARK_DIR"
    fi
    print_success "Cleanup complete"
}

# Benchmark: Sequential installation
benchmark_sequential_install() {
    print_header "Benchmark: Sequential Installation"
    
    export ZPM_MAX_JOBS=1
    
    local total_time=0
    for plugin in "${TEST_PLUGINS[@]}"; do
        local time=$(time_operation "Installing $plugin" zpm install "$plugin")
        total_time=$(echo "$total_time + $time" | bc)
        print_result "  $plugin: ${time}s"
    done
    
    print_result "Total time (sequential): ${total_time}s"
    echo "$total_time"
}

# Benchmark: Parallel installation
benchmark_parallel_install() {
    print_header "Benchmark: Parallel Installation"
    
    # Clean up previous installation
    rm -rf "$ZPM_DIR"
    zpm init &>/dev/null
    
    export ZPM_MAX_JOBS=10
    
    local start=$(date +%s.%N)
    zpm install "${TEST_PLUGINS[@]}"
    local end=$(date +%s.%N)
    
    local duration=$(echo "$end - $start" | bc)
    print_result "Total time (parallel): ${duration}s"
    echo "$duration"
}

# Benchmark: Plugin loading
benchmark_loading() {
    print_header "Benchmark: Plugin Loading"
    
    local total_time=0
    local count=0
    
    for plugin in "${TEST_PLUGINS[@]}"; do
        local name="${plugin##*/}"
        if [[ -d "$ZPM_DIR/plugins/$name" ]]; then
            local time=$(time_operation "Loading $name" zpm load "$name")
            total_time=$(echo "$total_time + $time" | bc)
            ((count++))
            print_result "  $name: ${time}s"
        fi
    done
    
    if [[ $count -gt 0 ]]; then
        local avg=$(echo "scale=4; $total_time / $count" | bc)
        print_result "Average load time: ${avg}s"
        print_result "Total load time: ${total_time}s"
    fi
}

# Benchmark: Plugin updates
benchmark_updates() {
    print_header "Benchmark: Plugin Updates"
    
    export ZPM_MAX_JOBS=10
    
    local start=$(date +%s.%N)
    zpm update
    local end=$(date +%s.%N)
    
    local duration=$(echo "$end - $start" | bc)
    print_result "Update time: ${duration}s"
}

# Calculate speedup
calculate_speedup() {
    local sequential="$1"
    local parallel="$2"
    
    print_header "Performance Summary"
    
    print_result "Sequential installation: ${sequential}s"
    print_result "Parallel installation:   ${parallel}s"
    
    if command -v bc &>/dev/null; then
        local speedup=$(echo "scale=2; $sequential / $parallel" | bc)
        local improvement=$(echo "scale=2; ($sequential - $parallel) / $sequential * 100" | bc)
        
        echo ""
        echo -e "${GREEN}${BOLD}Speedup: ${speedup}x faster${NC}"
        echo -e "${GREEN}${BOLD}Improvement: ${improvement}% faster${NC}"
        echo ""
    fi
}

# Memory usage
check_memory() {
    print_header "Memory Usage"
    
    if [[ -d "$ZPM_DIR" ]]; then
        local size=$(du -sh "$ZPM_DIR" 2>/dev/null | cut -f1)
        print_result "ZPM directory size: $size"
    fi
    
    local plugins_count=$(ls -1 "$ZPM_DIR/plugins" 2>/dev/null | wc -l)
    print_result "Plugins installed: $plugins_count"
}

# Main benchmark flow
main() {
    print_header "ZPM Performance Benchmark"
    
    echo "Testing with ${#TEST_PLUGINS[@]} plugins:"
    for plugin in "${TEST_PLUGINS[@]}"; do
        echo "  - $plugin"
    done
    
    setup
    
    # Run benchmarks
    local seq_time=$(benchmark_sequential_install)
    local par_time=$(benchmark_parallel_install)
    
    benchmark_loading
    benchmark_updates
    check_memory
    
    calculate_speedup "$seq_time" "$par_time"
    
    cleanup
    
    print_success "Benchmark complete!"
}

# Trap cleanup
trap cleanup EXIT INT TERM

# Run if bc is available
if ! command -v bc &>/dev/null; then
    echo -e "${YELLOW}Warning: 'bc' not found. Install for more detailed timing.${NC}"
    echo ""
fi

# Run main
main "$@"
