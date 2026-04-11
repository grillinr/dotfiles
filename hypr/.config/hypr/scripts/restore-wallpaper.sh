#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */
# Wallpaper restoration script - restores the last selected wallpaper on startup

# Color output helpers
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Configuration
CACHE_FILE="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"
MAX_RETRIES=10
RETRY_DELAY=1

# swww transition config
TYPE="any"
DURATION=2
BEZIER=".65,.05,.36,1"
SWWW_PARAMS="--transition-fps 60 --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# Function to check if awww-daemon is running
wait_for_awww_daemon() {
    local retry_count=0
    
    print_info "Waiting for awww-daemon to be ready..."
    
    while [[ $retry_count -lt $MAX_RETRIES ]]; do
        if pgrep -x "awww-daemon" >/dev/null; then
            # Give awww-daemon a moment to initialize
            sleep 1
            # Check if awww can communicate with the daemon
            if awww query >/dev/null 2>&1; then
                print_success "awww-daemon is ready"
                return 0
            fi
        fi
        
        print_info "Attempt $((retry_count + 1))/$MAX_RETRIES - waiting for awww-daemon..."
        sleep $RETRY_DELAY
        retry_count=$((retry_count + 1))
    done
    
    print_error "awww-daemon failed to start after $MAX_RETRIES attempts"
    return 1
}

# Function to restore wallpaper
restore_wallpaper() {
    # Check if cache file exists
    if [[ ! -f "$CACHE_FILE" ]]; then
        print_warning "No cached wallpaper found at: $CACHE_FILE"
        return 1
    fi
    
    # Read cached wallpaper path
    local wallpaper_path
    wallpaper_path=$(cat "$CACHE_FILE")
    
    if [[ -z "$wallpaper_path" ]]; then
        print_error "Cache file is empty"
        return 1
    fi
    
    # Check if wallpaper file exists
    if [[ ! -f "$wallpaper_path" ]]; then
        print_error "Cached wallpaper file not found: $wallpaper_path"
        return 1
    fi
    
    # Wait for awww-daemon to be ready
    if ! wait_for_awww_daemon; then
        return 1
    fi
    
    # Get focused monitor
    local focused_monitor
    focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
    
    if [[ -z "$focused_monitor" ]]; then
        print_error "Could not detect focused monitor"
        return 1
    fi
    
    print_info "Restoring wallpaper: $(basename "$wallpaper_path")"
    print_info "Target monitor: $focused_monitor"
    
    # Apply wallpaper
    if awww img -o "$focused_monitor" "$wallpaper_path" $SWWW_PARAMS; then
        print_success "Wallpaper restored successfully"
        return 0
    else
        print_error "Failed to restore wallpaper"
        return 1
    fi
}

# Main execution
main() {
    print_info "Starting wallpaper restoration..."
    
    # Check dependencies
    for cmd in hyprctl jq awww; do
        if ! command -v "$cmd" &>/dev/null; then
            print_error "Required command '$cmd' not found"
            exit 1
        fi
    done
    
    if restore_wallpaper; then
        print_success "Wallpaper restoration completed"
    else
        print_warning "Wallpaper restoration failed - this is normal if no wallpaper was previously selected"
    fi
}

# Run main function
main "$@"