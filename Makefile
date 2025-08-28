# Makefile for Dotfiles Management
# Provides easy commands for installing, uninstalling, and testing dotfiles

.PHONY: help install uninstall test clean backup

# Default target
help:
	@echo "Dotfiles Management Commands:"
	@echo ""
	@echo "  make install    - Install all dotfiles using GNU Stow"
	@echo "  make uninstall  - Remove all dotfiles using GNU Stow"
	@echo "  make test       - Test the installation process without installing"
	@echo "  make backup     - Create backup of existing configs"
	@echo "  make clean      - Remove backup directories"
	@echo "  make help       - Show this help message"
	@echo ""

# Install dotfiles
install:
	@echo "Installing dotfiles..."
	@./install.sh

# Uninstall dotfiles
uninstall:
	@echo "Uninstalling dotfiles..."
	@./uninstall.sh

# Test installation process
test:
	@echo "Testing dotfiles repository..."
	@./test-install.sh

# Create backup of existing configs
backup:
	@echo "Creating backup of existing configs..."
	@mkdir -p ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)
	@if [ -d ~/.config/nvim ]; then cp -r ~/.config/nvim ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/nvim; fi
	@if [ -d ~/.config/kitty ]; then cp -r ~/.config/kitty ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/kitty; fi
	@if [ -d ~/.config/waybar ]; then cp -r ~/.config/waybar ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/waybar; fi
	@if [ -d ~/.config/rofi ]; then cp -r ~/.config/rofi ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/rofi; fi
	@if [ -d ~/.config/swaync ]; then cp -r ~/.config/swaync ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/swaync; fi
	@if [ -d ~/.config/wlogout ]; then cp -r ~/.config/wlogout ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/wlogout; fi
	@if [ -d ~/.config/wofi ]; then cp -r ~/.config/wofi ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/wofi; fi
	@if [ -d ~/.config/hypr ]; then cp -r ~/.config/hypr ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/hypr; fi
	@if [ -d ~/.config/fastfetch ]; then cp -r ~/.config/fastfetch ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/fastfetch; fi
	@if [ -f ~/.zshrc ]; then cp ~/.zshrc ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/zshrc; fi
	@echo "Backup created in ~/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)"

# Clean backup directories
clean:
	@echo "Removing backup directories..."
	@rm -rf ~/.dotfiles_backup_*
	@echo "Backup directories removed"

# Show status of installed dotfiles
status:
	@echo "Checking status of dotfiles..."
	@echo ""
	@if [ -L ~/.config/nvim ]; then echo "✓ Neovim config installed"; else echo "✗ Neovim config not installed"; fi
	@if [ -L ~/.config/kitty ]; then echo "✓ Kitty config installed"; else echo "✗ Kitty config not installed"; fi
	@if [ -L ~/.config/waybar ]; then echo "✓ Waybar config installed"; else echo "✗ Waybar config not installed"; fi
	@if [ -L ~/.config/rofi ]; then echo "✓ Rofi config installed"; else echo "✗ Rofi config not installed"; fi
	@if [ -L ~/.config/swaync ]; then echo "✓ Swaync config installed"; else echo "✗ Swaync config not installed"; fi
	@if [ -L ~/.config/wlogout ]; then echo "✓ Wlogout config installed"; else echo "✗ Wlogout config not installed"; fi
	@if [ -L ~/.config/wofi ]; then echo "✓ Wofi config installed"; else echo "✗ Wofi config not installed"; fi
	@if [ -L ~/.config/hypr ]; then echo "✓ Hyprland config installed"; else echo "✗ Hyprland config not installed"; fi
	@if [ -L ~/.config/fastfetch ]; then echo "✓ Fastfetch config installed"; else echo "✗ Fastfetch config not installed"; fi
	@if [ -L ~/.zshrc ]; then echo "✓ Zsh config installed"; else echo "✗ Zsh config not installed"; fi
	@echo ""
	@if [ -L ~/Pictures/wallpapers ]; then echo "✓ Wallpapers symlink created"; else echo "✗ Wallpapers symlink not created"; fi
	@if [ -L ~/Pictures/walls ]; then echo "✓ Walls directory symlink created"; else echo "✗ Walls directory symlink not created"; fi
