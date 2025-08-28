#!/bin/bash

# Dotfiles Install Script for Arch Linux
# This script installs all necessary packages and uses GNU Stow to install dotfiles

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

# Function to check if running on Arch
check_arch() {
    if ! command_exists pacman; then
        print_error "This script is designed for Arch Linux (pacman package manager)"
        exit 1
    fi
}

# Function to install packages from package-list.txt
install_packages() {
    print_status "Installing packages from package-list.txt..."
    
    if [[ -f "packages/package-list.txt" ]]; then
        # Filter out comments and empty lines, then install
        packages=$(grep -v '^#' packages/package-list.txt | grep -v '^$' | tr '\n' ' ')
        
        if [[ -n "$packages" ]]; then
            print_status "Installing packages: $packages"
            sudo pacman -S --needed --noconfirm $packages
            print_success "Packages installed successfully"
        else
            print_warning "No packages found in package-list.txt"
        fi
    else
        print_warning "package-list.txt not found, skipping package installation"
    fi
}

# Function to install AUR packages
install_aur_packages() {
    print_status "Installing AUR packages..."
    
    if [[ -f "packages/aur-packages.txt" ]]; then
        # Check if yay is available
        if command_exists yay; then
            packages=$(grep -v '^#' packages/aur-packages.txt | grep -v '^$' | tr '\n' ' ')
            
            if [[ -n "$packages" ]]; then
                print_status "Installing AUR packages: $packages"
                yay -S --needed --noconfirm $packages
                print_success "AUR packages installed successfully"
            else
                print_warning "No AUR packages found in aur-packages.txt"
            fi
        else
            print_warning "yay not found, skipping AUR package installation"
            print_status "You can install yay manually: sudo pacman -S yay"
        fi
    else
        print_warning "aur-packages.txt not found, skipping AUR package installation"
    fi
}

# Function to install GNU Stow if not present
install_stow() {
    if ! command_exists stow; then
        print_status "Installing GNU Stow..."
        sudo pacman -S --needed --noconfirm stow
        print_success "GNU Stow installed successfully"
    else
        print_success "GNU Stow is already installed"
    fi
}

# Function to backup existing configs
backup_existing_configs() {
    print_status "Checking for existing configs..."
    
    # List of config directories to check
    config_dirs=(
        ".config/nvim"
        ".config/kitty"
        ".config/waybar"
        ".config/rofi"
        ".config/swaync"
        ".config/wlogout"
        ".config/wofi"
        ".config/hypr"
        ".config/fastfetch"
        ".zshrc"
    )
    
    backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    for config in "${config_dirs[@]}"; do
        if [[ -e "$HOME/$config" ]]; then
            print_warning "Found existing config: $config"
            print_status "Backing up to: $backup_dir/$config"
            mkdir -p "$(dirname "$backup_dir/$config")"
            cp -r "$HOME/$config" "$backup_dir/$config"
        fi
    done
    
    if [[ "$(ls -A "$backup_dir")" ]]; then
        print_success "Backups created in: $backup_dir"
    else
        rmdir "$backup_dir"
    fi
}

# Function to install dotfiles using Stow
install_dotfiles() {
    print_status "Installing dotfiles using GNU Stow..."
    
    # List of directories to stow (excluding non-config dirs)
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
            print_status "Installing $dir..."
            stow -t "$HOME" "$dir"
            print_success "$dir installed successfully"
        else
            print_warning "Directory $dir not found, skipping"
        fi
    done
    
    print_success "All dotfiles installed successfully!"
}

# Function to create wallpapers symlink
setup_wallpapers() {
    if [[ -d "wallpapers" ]]; then
        print_status "Setting up wallpapers..."
        
        # Create wallpapers directory if it doesn't exist
        mkdir -p "$HOME/Pictures"
        
        # Create symlink to wallpapers (handle nested structure)
        if [[ ! -L "$HOME/Pictures/wallpapers" ]]; then
            ln -sf "$(pwd)/wallpapers" "$HOME/Pictures/wallpapers"
            print_success "Wallpapers symlink created"
        else
            print_success "Wallpapers symlink already exists"
        fi
        
        # Also create a direct symlink to the walls subdirectory for easier access
        if [[ -d "wallpapers/wallpapers/walls" ]] && [[ ! -L "$HOME/Pictures/walls" ]]; then
            ln -sf "$(pwd)/wallpapers/wallpapers/walls" "$HOME/Pictures/walls"
            print_success "Walls directory symlink created"
        fi
    fi
}

# Function to set up additional configurations
setup_additional_configs() {
    print_status "Setting up additional configurations..."
    
    # Make sure .config directory exists
    mkdir -p "$HOME/.config"
    
    # Set proper permissions for config files
    find "$HOME/.config" -type f -exec chmod 644 {} \;
    find "$HOME/.config" -type d -exec chmod 755 {} \;
    
    # Make scripts executable
    find "$HOME/.config" -name "*.sh" -exec chmod +x {} \;
    
    print_success "Additional configurations set up"
}

# Function to display completion message
show_completion_message() {
    echo
    print_success "Installation completed successfully!"
    echo
    echo "Your dotfiles have been installed using GNU Stow."
    echo "If you need to uninstall any specific config, you can use:"
    echo "  stow -D -t \$HOME <config-name>"
    echo
    echo "To uninstall all configs:"
    echo "  stow -D -t \$HOME <config-name>"
    echo
    echo "Remember to restart your applications or log out/in for changes to take effect."
    echo
}

# Main execution
main() {
    echo "=========================================="
    echo "    Dotfiles Install Script for Arch"
    echo "=========================================="
    echo
    
    # Pre-flight checks
    check_root
    check_arch
    
    # Install packages
    install_packages
    install_aur_packages
    
    # Install GNU Stow
    install_stow
    
    # Backup existing configs
    backup_existing_configs
    
    # Install dotfiles
    install_dotfiles
    
    # Setup additional configurations
    setup_wallpapers
    setup_additional_configs
    
    # Show completion message
    show_completion_message
}

# Run main function
main "$@"
