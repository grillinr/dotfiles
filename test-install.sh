#!/bin/bash

# Test Install Script for Dotfiles
# This script tests the installation process without actually installing anything

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# Function to check if file exists
file_exists() {
    [[ -f "$1" ]]
}

# Function to check if directory exists
dir_exists() {
    [[ -d "$1" ]]
}

# Function to test package files
test_package_files() {
    print_status "Testing package files..."
    
    if file_exists "packages/package-list.txt"; then
        print_success "package-list.txt found"
        
        # Check if file has content
        if [[ -s "packages/package-list.txt" ]]; then
            print_success "package-list.txt has content"
        else
            print_error "package-list.txt is empty"
        fi
    else
        print_error "package-list.txt not found"
    fi
    
    if file_exists "packages/aur-packages.txt"; then
        print_success "aur-packages.txt found"
        
        # Check if file has content
        if [[ -s "packages/aur-packages.txt" ]]; then
            print_success "aur-packages.txt has content"
        else
            print_error "aur-packages.txt is empty"
        fi
    else
        print_error "aur-packages.txt not found"
    fi
}

# Function to test dotfile directories
test_dotfile_dirs() {
    print_status "Testing dotfile directories..."
    
    # List of expected directories
    expected_dirs=(
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
    
    for dir in "${expected_dirs[@]}"; do
        if dir_exists "$dir"; then
            print_success "$dir directory found"
            
            # Check if it has the expected structure
            if [[ "$dir" == "zshrc" ]]; then
                if file_exists "$dir/.zshrc"; then
                    print_success "$dir/.zshrc found"
                else
                    print_warning "$dir/.zshrc not found"
                fi
            else
                if dir_exists "$dir/.config"; then
                    print_success "$dir/.config directory found"
                else
                    print_warning "$dir/.config directory not found"
                fi
            fi
        else
            print_error "$dir directory not found"
        fi
    done
}

# Function to test wallpapers directory
test_wallpapers() {
    print_status "Testing wallpapers directory..."
    
    if dir_exists "wallpapers"; then
        print_success "wallpapers directory found"
        
        if dir_exists "wallpapers/walls"; then
            print_success "wallpapers/walls directory found"
            
            # Count wallpaper files
            wallpaper_count=$(find "wallpapers/walls" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null | wc -l)
            print_status "Found $wallpaper_count wallpaper files"
        else
            print_warning "wallpapers/walls directory not found"
        fi
    else
        print_warning "wallpapers directory not found"
    fi
}

# Function to test install script
test_install_script() {
    print_status "Testing install script..."
    
    if file_exists "install.sh"; then
        print_success "install.sh found"
        
        # Check if it's executable
        if [[ -x "install.sh" ]]; then
            print_success "install.sh is executable"
        else
            print_warning "install.sh is not executable"
        fi
        
        # Check if it has content
        if [[ -s "install.sh" ]]; then
            print_success "install.sh has content"
        else
            print_error "install.sh is empty"
        fi
    else
        print_error "install.sh not found"
    fi
}

# Function to test uninstall script
test_uninstall_script() {
    print_status "Testing uninstall script..."
    
    if file_exists "uninstall.sh"; then
        print_success "uninstall.sh found"
        
        # Check if it's executable
        if [[ -x "uninstall.sh" ]]; then
            print_success "uninstall.sh is executable"
        else
            print_warning "uninstall.sh is not executable"
        fi
        
        # Check if it has content
        if [[ -s "uninstall.sh" ]]; then
            print_success "uninstall.sh has content"
        else
            print_error "uninstall.sh is empty"
        fi
    else
        print_warning "uninstall.sh not found"
    fi
}

# Function to test README
test_readme() {
    print_status "Testing README..."
    
    if file_exists "README.md"; then
        print_success "README.md found"
        
        # Check if it has content
        if [[ -s "README.md" ]]; then
            print_success "README.md has content"
        else
            print_error "README.md is empty"
        fi
    else
        print_warning "README.md not found"
    fi
}

# Function to run syntax check on bash scripts
test_bash_syntax() {
    print_status "Testing bash script syntax..."
    
    local scripts=("install.sh" "uninstall.sh")
    
    for script in "${scripts[@]}"; do
        if file_exists "$script"; then
            if bash -n "$script" 2>/dev/null; then
                print_success "$script syntax is valid"
            else
                print_error "$script syntax is invalid"
            fi
        fi
    done
}

# Function to show test summary
show_test_summary() {
    echo
    echo "=========================================="
    echo "           Test Summary"
    echo "=========================================="
    echo
    echo "This test script verified:"
    echo "  ✓ Package files existence and content"
    echo "  ✓ Dotfile directory structure"
    echo "  ✓ Wallpapers directory"
    echo "  ✓ Install script existence and permissions"
    echo "  ✓ Uninstall script existence and permissions"
    echo "  ✓ README documentation"
    echo "  ✓ Bash script syntax"
    echo
    echo "If all tests passed, your dotfiles repository"
    echo "is ready for installation!"
    echo
}

# Main execution
main() {
    echo "=========================================="
    echo "    Dotfiles Test Script"
    echo "=========================================="
    echo
    
    # Run all tests
    test_package_files
    echo
    test_dotfile_dirs
    echo
    test_wallpapers
    echo
    test_install_script
    echo
    test_uninstall_script
    echo
    test_readme
    echo
    test_bash_syntax
    echo
    
    # Show summary
    show_test_summary
}

# Run main function
main "$@"
