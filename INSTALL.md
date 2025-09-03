# Quick Installation Guide

## 🚀 Fast Installation

```bash
# Clone your dotfiles
git clone <your-repo-url>
cd dotfiles

# Run the install script
./install.sh
```

## 🛠️ Alternative Installation Methods

### Using Make
```bash
make install      # Install all dotfiles
make uninstall    # Remove all dotfiles
make test         # Test the repository
make status       # Check installation status
make help         # Show all commands
```

### Manual Installation
```bash
# Install packages
sudo pacman -S --needed $(cat packages/package-list.txt)
yay -S --needed $(cat packages/aur-packages.txt)

# Install GNU Stow
sudo pacman -S stow

# Install dotfiles
stow -t $HOME nvim kitty waybar rofi swaync wlogout wofi hypr fastfetch zshrc
```

## 📁 What Gets Installed

- **Neovim** - Enhanced Vim with Lua config
- **Kitty** - Fast terminal emulator
- **Waybar** - Customizable status bar
- **Rofi** - Application launcher
- **Swaync** - Notification daemon
- **Wlogout** - Logout screen
- **Wofi** - Alternative launcher
- **Hyprland** - Modern Wayland compositor
- **Fastfetch** - System information
- **Zsh** - Enhanced shell configuration
- **Wallpapers** - Collection of wallpapers

## 🔧 Post-Installation

1. **Restart your terminal** for Zsh changes to take effect
2. **Log out and back in** for Hyprland changes
3. **Restart applications** for config changes

## 🚨 Troubleshooting

- **Permission denied**: Run `chmod +x install.sh`
- **Package conflicts**: Update with `sudo pacman -Sy`
- **Stow conflicts**: Remove existing configs first
- **AUR packages fail**: Install yay first: `sudo pacman -S yay`

## 📚 More Information

- See `README.md` for detailed documentation
- Run `./test-install.sh` to verify your setup
- Use `make help` for available commands

## 🔄 Updating

```bash
# Pull latest changes
git pull origin main

# Reinstall dotfiles
make install
```

## 🗑️ Uninstalling

```bash
# Remove all dotfiles
./uninstall.sh

# Or use make
make uninstall
```

