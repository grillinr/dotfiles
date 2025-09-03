#!/bin/bash

# NixOS Configuration Installation Script
# This script helps install the NixOS configuration from your dotfiles

set -e

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

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root"
        exit 1
    fi
}

# Function to check if NixOS is installed
check_nixos() {
    if [[ ! -f /etc/nixos/configuration.nix ]]; then
        print_error "NixOS is not installed or configuration not found"
        print_status "Please install NixOS first"
        exit 1
    fi
}

# Function to backup existing configuration
backup_config() {
    print_status "Backing up existing NixOS configuration..."
    
    backup_dir="/etc/nixos/backup-$(date +%Y%m%d_%H%M%S)"
    sudo mkdir -p "$backup_dir"
    
    if [[ -f /etc/nixos/configuration.nix ]]; then
        sudo cp /etc/nixos/configuration.nix "$backup_dir/"
        print_success "Backed up configuration.nix"
    fi
    
    if [[ -f /etc/nixos/hardware-configuration.nix ]]; then
        sudo cp /etc/nixos/hardware-configuration.nix "$backup_dir/"
        print_success "Backed up hardware-configuration.nix"
    fi
    
    if [[ -f /etc/nixos/flake.nix ]]; then
        sudo cp /etc/nixos/flake.nix "$backup_dir/"
        print_success "Backed up flake.nix"
    fi
    
    print_success "Backup created in $backup_dir"
}

# Function to copy configuration files
copy_config() {
    print_status "Copying NixOS configuration files..."
    
    # Copy flake.nix
    sudo cp flake.nix /etc/nixos/
    print_success "Copied flake.nix"
    
    # Copy configuration.nix
    sudo cp configuration.nix /etc/nixos/
    print_success "Copied configuration.nix"
    
    # Copy home.nix
    sudo cp home.nix /etc/nixos/
    print_success "Copied home.nix"
    
    # Copy README.md
    sudo cp README.md /etc/nixos/
    print_success "Copied README.md"
    
    # Copy dotfiles directory structure
    print_status "Copying dotfiles..."
    sudo cp -r hypr /etc/nixos/
    sudo cp -r waybar /etc/nixos/
    sudo cp -r kitty /etc/nixos/
    sudo cp -r rofi /etc/nixos/
    sudo cp -r swaync /etc/nixos/
    sudo cp -r wlogout /etc/nixos/
    sudo cp -r wofi /etc/nixos/
    sudo cp -r fastfetch /etc/nixos/
    sudo cp -r nvim /etc/nixos/
    sudo cp -r zshrc /etc/nixos/
    sudo cp -r wallpapers /etc/nixos/
    
    print_success "Copied all dotfiles"
}

# Function to generate hardware configuration
generate_hardware_config() {
    print_status "Generating hardware configuration..."
    
    if [[ -f /etc/nixos/hardware-configuration.nix ]]; then
        print_warning "hardware-configuration.nix already exists"
        print_status "Please review and update UUIDs in the file"
    else
        print_status "Generating new hardware configuration..."
        sudo nixos-generate-config --show-hardware-config > /tmp/hardware-configuration.nix
        sudo mv /tmp/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
        print_success "Generated hardware-configuration.nix"
        print_warning "Please review and update UUIDs in /etc/nixos/hardware-configuration.nix"
    fi
}

# Function to build configuration
build_config() {
    print_status "Building NixOS configuration..."
    
    cd /etc/nixos
    
    # Test build first
    print_status "Testing configuration build..."
    if sudo nixos-rebuild build --flake .#nixos; then
        print_success "Configuration builds successfully"
    else
        print_error "Configuration build failed"
        print_status "Please check the error messages above"
        exit 1
    fi
    
    # Ask for confirmation before switching
    echo
    print_warning "Configuration builds successfully!"
    print_status "Do you want to switch to the new configuration? (y/N)"
    read -r response
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        print_status "Switching to new configuration..."
        if sudo nixos-rebuild switch --flake .#nixos; then
            print_success "Successfully switched to new configuration!"
        else
            print_error "Failed to switch configuration"
            exit 1
        fi
    else
        print_status "Configuration built but not switched"
        print_status "You can switch later with: sudo nixos-rebuild switch --flake .#nixos"
    fi
}

# Function to show completion message
show_completion_message() {
    echo
    print_success "Installation completed successfully!"
    echo
    echo "Your NixOS configuration has been installed."
    echo
    echo "Next steps:"
    echo "1. Review /etc/nixos/hardware-configuration.nix and update UUIDs if needed"
    echo "2. If you didn't switch yet, run: sudo nixos-rebuild switch --flake .#nixos"
    echo "3. Reboot your system to apply all changes"
    echo
    echo "Useful commands:"
    echo "  sudo nixos-rebuild switch --flake .#nixos  # Apply configuration"
    echo "  sudo nixos-rebuild boot --flake .#nixos    # Apply on next boot"
    echo "  nix flake update                           # Update flake inputs"
    echo "  home-manager switch --flake .#nixos        # Apply Home Manager config"
    echo
}

# Main execution
main() {
    echo "=========================================="
    echo "    NixOS Configuration Installer"
    echo "=========================================="
    echo
    
    # Pre-flight checks
    check_root
    check_nixos
    
    # Installation steps
    backup_config
    copy_config
    generate_hardware_config
    build_config
    
    # Show completion message
    show_completion_message
}

# Run main function
main "$@"