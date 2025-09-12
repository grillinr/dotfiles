#!/bin/bash

# Arch Linux Dotfiles Installation Script
# This script helps install dotfiles and packages on Arch Linux

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

# Function to check if Arch Linux is installed
check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        print_error "Arch Linux is not detected"
        print_status "This script is designed for Arch Linux"
        exit 1
    fi
}

# Function to check if yay is installed
check_yay() {
    if ! command -v yay &> /dev/null; then
        print_warning "yay (AUR helper) is not installed"
        print_status "Installing yay..."
        install_yay
    fi
}

# Function to install yay
install_yay() {
    print_status "Installing yay AUR helper..."
    
    # Install base-devel if not present
    if ! pacman -Q base-devel &> /dev/null; then
        print_status "Installing base-devel..."
        sudo pacman -S --needed --noconfirm base-devel
    fi
    
    # Install git if not present
    if ! pacman -Q git &> /dev/null; then
        print_status "Installing git..."
        sudo pacman -S --needed --noconfirm git
    fi
    
    # Clone and install yay
    cd /tmp
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    cd "$OLDPWD"
    rm -rf /tmp/yay-bin
    
    print_success "yay installed successfully"
}

# Function to backup existing dotfiles
backup_dotfiles() {
    print_status "Backing up existing dotfiles..."
    
    backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    # List of common dotfiles to backup
    dotfiles=(
        ".zshrc"
        ".config/hypr"
        ".config/waybar"
        ".config/kitty"
        ".config/rofi"
        ".config/swaync"
        ".config/wlogout"
        ".config/wofi"
        ".config/fastfetch"
        ".config/nvim"
        ".config/wallpapers"
    )
    
    for dotfile in "${dotfiles[@]}"; do
        if [[ -e "$HOME/$dotfile" ]]; then
            cp -r "$HOME/$dotfile" "$backup_dir/"
            print_success "Backed up $dotfile"
        fi
    done
    
    print_success "Backup created in $backup_dir"
}

# Function to install stow if not present
install_stow() {
    if ! command -v stow &> /dev/null; then
        print_status "Installing stow..."
        sudo pacman -S --needed --noconfirm stow
    fi
}

# Function to symlink dotfiles using stow
symlink_dotfiles() {
    print_status "Symlinking dotfiles using stow..."
    
    # Install stow if not present
    install_stow
    
    # Get the directory where this script is located
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Change to the dotfiles directory
    cd "$script_dir"
    
    # Create symlinks for each configuration directory
    config_dirs=("hypr" "waybar" "kitty" "rofi" "swaync" "wlogout" "wofi" "fastfetch" "nvim" "zshrc" "wallpapers")
    
    for config_dir in "${config_dirs[@]}"; do
        if [[ -d "$config_dir" ]]; then
            print_status "Symlinking $config_dir..."
            stow -t "$HOME" "$config_dir"
            print_success "Symlinked $config_dir"
        else
            print_warning "$config_dir directory not found, skipping..."
        fi
    done
    
    print_success "All dotfiles symlinked successfully"
}

# Function to install packages from package list
install_packages() {
    print_status "Installing packages from package list..."
    
    # Get the directory where this script is located
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Install packages from package-list.txt
    if [[ -f "$script_dir/packages/package-list.txt" ]]; then
        print_status "Installing packages from package-list.txt..."
        sudo pacman -S --needed --noconfirm $(cat "$script_dir/packages/package-list.txt" | grep -v '^#' | tr '\n' ' ')
        print_success "Installed packages from package-list.txt"
    else
        print_warning "package-list.txt not found, skipping package installation"
    fi
}

# Function to install AUR packages
install_aur_packages() {
    print_status "Installing AUR packages..."
    
    # Get the directory where this script is located
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Install AUR packages from aur-packages.txt
    if [[ -f "$script_dir/packages/aur-packages.txt" ]]; then
        print_status "Installing AUR packages from aur-packages.txt..."
        yay -S --needed --noconfirm $(cat "$script_dir/packages/aur-packages.txt" | grep -v '^#' | tr '\n' ' ')
        print_success "Installed AUR packages from aur-packages.txt"
    else
        print_warning "aur-packages.txt not found, skipping AUR package installation"
    fi
}

# Function to enable system services
enable_services() {
    print_status "Enabling system services..."
    
    # List of services to enable
    services=(
        "NetworkManager"
        "bluetooth"
        "sddm"
        "pipewire"
        "pipewire-pulse"
        "wireplumber"
    )
    
    for service in "${services[@]}"; do
        if systemctl list-unit-files | grep -q "$service.service"; then
            print_status "Enabling $service..."
            sudo systemctl enable "$service"
            print_success "Enabled $service"
        else
            print_warning "$service service not found, skipping..."
        fi
    done
    
    print_success "System services enabled"
}

# Function to add user to groups
add_user_groups() {
    print_status "Adding user to necessary groups..."
    
    # List of groups to add user to
    groups=(
        "audio"
        "video"
        "input"
        "wheel"
        "network"
        "storage"
        "optical"
        "lp"
        "scanner"
        "power"
        "adbusers"
        "docker"
        "libvirt"
    )
    
    for group in "${groups[@]}"; do
        if getent group "$group" > /dev/null 2>&1; then
            print_status "Adding user to $group group..."
            sudo usermod -aG "$group" "$USER"
            print_success "Added user to $group group"
        else
            print_warning "$group group not found, skipping..."
        fi
    done
    
    print_success "User groups configured"
}

# Function to show completion message
show_completion_message() {
    echo
    print_success "Installation completed successfully!"
    echo
    echo "Your Arch Linux dotfiles have been installed."
    echo
    echo "Next steps:"
    echo "1. Reboot your system to apply all changes"
    echo "2. Log in and start using your new configuration"
    echo "3. Check that all services are running properly"
    echo
    echo "Useful commands:"
    echo "  systemctl status <service>                 # Check service status"
    echo "  systemctl enable <service>                 # Enable a service"
    echo "  systemctl start <service>                  # Start a service"
    echo "  pacman -Syu                                # Update system packages"
    echo "  yay -Syu                                   # Update AUR packages"
    echo "  stow -D <package>                          # Remove symlinks for a package"
    echo "  stow <package>                             # Re-symlink a package"
    echo
    echo "Configuration files are located in:"
    echo "  ~/.config/                                 # Application configs"
    echo "  ~/.zshrc                                   # Zsh configuration"
    echo
}

# Main execution
main() {
    echo "=========================================="
    echo "    Arch Linux Dotfiles Installer"
    echo "=========================================="
    echo
    
    # Pre-flight checks
    check_root
    check_arch
    check_yay
    
    # Installation steps
    backup_dotfiles
    install_packages
    install_aur_packages
    symlink_dotfiles
    enable_services
    add_user_groups
    
    # Show completion message
    show_completion_message
}

# Run main function
main "$@"