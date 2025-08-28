#!/bin/bash

# Dotfiles Uninstall Script
# This script removes all dotfiles using GNU Stow

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root"
        exit 1
    fi
}

# Function to check if GNU Stow is available
check_stow() {
    if ! command_exists stow; then
        print_error "GNU Stow is not installed. Cannot uninstall dotfiles."
        exit 1
    fi
}

# Function to uninstall dotfiles
uninstall_dotfiles() {
    print_status "Uninstalling dotfiles using GNU Stow..."
    
    # List of directories to unstow
    stow_dirs=(
        "nvim"
        "kitty"
        "waybar"
        "rofi"
        "swaync"
        "wlogout"
        "wofi"
        "hypr"
        "fastfetch"
        "zshrc"
    )
    
    for dir in "${stow_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            print_status "Uninstalling $dir..."
            if stow -D -t "$HOME" "$dir" 2>/dev/null; then
                print_success "$dir uninstalled successfully"
            else
                print_warning "$dir was not installed or already removed"
            fi
        else
            print_warning "Directory $dir not found, skipping"
        fi
    done
}

# Function to remove wallpapers symlink
remove_wallpapers() {
    if [[ -L "$HOME/Pictures/wallpapers" ]]; then
        print_status "Removing wallpapers symlink..."
        rm "$HOME/Pictures/wallpapers"
        print_success "Wallpapers symlink removed"
    else
        print_status "Wallpapers symlink not found"
    fi
    
    if [[ -L "$HOME/Pictures/walls" ]]; then
        print_status "Removing walls directory symlink..."
        rm "$HOME/Pictures/walls"
        print_success "Walls directory symlink removed"
    else
        print_status "Walls directory symlink not found"
    fi
}

# Function to show completion message
show_completion_message() {
    echo
    print_success "Uninstallation completed successfully!"
    echo
    echo "All dotfiles have been removed using GNU Stow."
    echo "Your original configurations (if any) remain unchanged."
    echo
    echo "Note: If you had existing configs before installation,"
    echo "they were backed up in ~/.dotfiles_backup_*/ directories."
    echo
}

# Function to confirm uninstallation
confirm_uninstall() {
    echo "=========================================="
    echo "    Dotfiles Uninstall Script"
    echo "=========================================="
    echo
    echo "This script will remove all dotfiles installed by the install script."
    echo "This includes:"
    echo "  - Neovim configuration"
    echo "  - Kitty terminal configuration"
    echo "  - Waybar configuration"
    echo "  - Rofi configuration"
    echo "  - Swaync configuration"
    echo "  - Wlogout configuration"
    echo "  - Wofi configuration"
    echo "  - Hyprland configuration"
    echo "  - Fastfetch configuration"
    echo "  - Zsh configuration"
    echo "  - Wallpapers symlink"
    echo
    echo "WARNING: This will remove ALL dotfiles. Make sure you have backups!"
    echo
    read -p "Are you sure you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Uninstallation cancelled."
        exit 0
    fi
}

# Main execution
main() {
    # Pre-flight checks
    check_root
    check_stow
    
    # Confirm uninstallation
    confirm_uninstall
    
    # Uninstall dotfiles
    uninstall_dotfiles
    
    # Remove wallpapers
    remove_wallpapers
    
    # Show completion message
    show_completion_message
}

# Run main function
main "$@"
