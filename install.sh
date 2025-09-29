#!/bin/bash

# Dotfiles Install Script
# Installs packages and stows dotfiles from this repository
# Can be run via curl to bootstrap the entire installation

set -e # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
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

# Repository details
REPO_URL="https://github.com/grillinr/dotfiles.git"
REPO_NAME="dotfiles"
DOTFILES_DIR="$HOME/$REPO_NAME"

# Function to install git if not available
install_git() {
  if ! command -v git &>/dev/null; then
    print_info "Installing git..."
    if command -v pacman &>/dev/null; then
      sudo pacman -S --needed git
    else
      print_error "Cannot install git. Please install git manually and run the script again."
      exit 1
    fi
    print_success "Git installed successfully"
  else
    print_info "Git is already installed"
  fi
}

# Function to clone or update the repository
setup_repository() {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  # If we're not in a git repository or not in the right repo, clone it
  if [[ ! -d "$script_dir/.git" ]] || ! git -C "$script_dir" remote get-url origin 2>/dev/null | grep -q "grillinr/dotfiles"; then
    print_info "Cloning dotfiles repository..."

    # Create parent directory if needed
    mkdir -p "$(dirname "$DOTFILES_DIR")"

    # Clone or update repository
    if [[ -d "$DOTFILES_DIR" ]]; then
      print_info "Updating existing dotfiles repository..."
      git -C "$DOTFILES_DIR" pull origin main || {
        print_warning "Failed to update repository, removing and re-cloning..."
        rm -rf "$DOTFILES_DIR"
        git clone "$REPO_URL" "$DOTFILES_DIR"
      }
    else
      git clone "$REPO_URL" "$DOTFILES_DIR"
    fi

    # Change to the repository directory and make the script executable
    cd "$DOTFILES_DIR"
    chmod +x install.sh

    print_success "Repository ready at $DOTFILES_DIR"
    return 0
  else
    print_info "Running from within dotfiles repository"
    DOTFILES_DIR="$script_dir"
    return 0
  fi
}

# Check if we're running as root (we shouldn't for most operations)
if [[ $EUID -eq 0 ]]; then
  print_error "This script should not be run as root"
  exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_DIR="$SCRIPT_DIR/packages"

print_info "Starting dotfiles installation..."

# Install git if needed and setup repository
install_git
setup_repository

# Update SCRIPT_DIR and PACKAGES_DIR after potential repository setup
SCRIPT_DIR="$DOTFILES_DIR"
PACKAGES_DIR="$SCRIPT_DIR/packages"

print_info "Installing from $SCRIPT_DIR"

# Check if packages directory exists
if [[ ! -d "$PACKAGES_DIR" ]]; then
  print_error "Packages directory not found: $PACKAGES_DIR"
  exit 1
fi

# Function to install packages with pacman
install_pacman_packages() {
  local pkglist="$PACKAGES_DIR/pkglist.txt"

  if [[ ! -f "$pkglist" ]]; then
    print_warning "Package list not found: $pkglist"
    return 1
  fi

  print_info "Installing packages with pacman..."
  if sudo pacman -S --needed - <"$pkglist"; then
    print_success "Pacman packages installed successfully"
    return 0
  else
    print_error "Failed to install pacman packages"
    return 1
  fi
}

# Function to install AUR packages with yay
install_aur_packages() {
  local aur_list="$PACKAGES_DIR/aur-installed.txt"

  if [[ ! -f "$aur_list" ]]; then
    print_warning "AUR package list not found: $aur_list"
    return 1
  fi

  # Check if yay is installed
  if ! command -v yay &>/dev/null; then
    print_warning "yay not found. Installing yay first..."
    if ! sudo pacman -S --needed yay; then
      print_error "Failed to install yay"
      return 1
    fi
  fi

  # Extract package names from AUR list (format: package-name version-info)
  local aur_packages=""
  while IFS= read -r line; do
    # Skip comments and empty lines
    [[ $line =~ ^[[:space:]]*#.*$ ]] && continue
    [[ -z "$line" ]] && continue

    # Skip the warning line at the top
    [[ $line == *"Avoid running yay as root/sudo."* ]] && continue

    # Extract package name (first word before version)
    package_name=$(echo "$line" | awk '{print $1}')
    if [[ -n "$package_name" && "$package_name" != "->" ]]; then
      aur_packages="$aur_packages $package_name"
    fi
  done <"$aur_list"

  if [[ -n "$aur_packages" ]]; then
    print_info "Installing AUR packages with yay..."
    # shellcheck disable=SC2086
    if yay -S --needed $aur_packages; then
      print_success "AUR packages installed successfully"
      return 0
    else
      print_error "Failed to install AUR packages"
      return 1
    fi
  else
    print_info "No AUR packages to install"
    return 0
  fi
}

# Function to install GNU Stow
install_stow() {
  if ! command -v stow &>/dev/null; then
    print_info "Installing GNU Stow..."
    if sudo pacman -S --needed stow; then
      print_success "GNU Stow installed successfully"
      return 0
    else
      print_error "Failed to install GNU Stow"
      return 1
    fi
  else
    print_info "GNU Stow is already installed"
    return 0
  fi
}

# Function to stow dotfiles
stow_dotfiles() {
  print_info "Stowing dotfiles..."

  # List of directories to stow (all directories except .git, packages, wallpapers, and install scripts)
  local stow_dirs=""
  while IFS= read -r -d '' dir; do
    local dir_name=$(basename "$dir")
    case "$dir_name" in
    ".git" | "packages" | "install.sh" | "INSTALL.md" | "README.md" | ".gitignore" | "pictures")
      # Skip these directories
      ;;
    *)
      stow_dirs="$stow_dirs $dir_name"
      ;;
    esac
  done < <(find "$SCRIPT_DIR" -maxdepth 1 -type d -print0)

  if [[ -z "$stow_dirs" ]]; then
    print_warning "No directories found to stow"
    return 1
  fi

  print_info "Will stow the following directories:$stow_dirs"

  # shellcheck disable=SC2086
  if stow -t "$HOME" $stow_dirs; then
    print_success "Dotfiles stowed successfully"
    return 0
  else
    print_error "Failed to stow dotfiles"
    return 1
  fi
}

# Main installation function
main() {
  print_info "=== Dotfiles Installation Started ==="

  # Install GNU Stow first (needed for dotfiles)
  install_stow || {
    print_error "Failed to install GNU Stow"
    exit 1
  }

  # Install packages
  install_pacman_packages || print_warning "Some pacman packages may have failed to install"
  install_aur_packages || print_warning "Some AUR packages may have failed to install"

  # Stow dotfiles
  stow_dotfiles || {
    print_error "Failed to stow dotfiles"
    exit 1
  }

  print_success "=== Dotfiles Installation Completed ==="
  print_info "Please restart your terminal and log out/in for changes to take effect"
  print_info ""
  print_info "Quick setup checklist:"
  print_info "1. Restart your terminal (new zsh config)"
  print_info "2. Log out and back in (Hyprland changes)"
  print_info "3. Run 'Hyprland' to start the desktop environment"
  print_info ""
  print_info "For more information, see: https://github.com/grillinr/dotfiles"
}

# Run the installation
main "$@"
