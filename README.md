# Arch Linux Dotfiles

This repository contains my Arch Linux dotfiles with a Gruvbox theme and configuration files, managed using `stow` for easy installation and maintenance.

## 🚀 Quick Installation

**ALWAYS READ SCRIPTS BEFORE RUNNING ON YOUR SYSTEM**

```bash
curl -fsSL https://github.com/grillinr/dotfiles/raw/main/install.sh | bash
```

## 🛠️ Installation

### Automatic Installation (Recommended)
The installation script will automatically:
- Install all required packages from official repositories and AUR
- Backup existing dotfiles
- Symlink all configuration files using `stow`
- Enable necessary system services
- Add user to required groups

### Manual Installation
```bash
# Install packages
sudo pacman -S --needed $(cat packages/pkglist.txt)
yay -S --needed $(cat packages/aur-installed.txt | grep -v "->" | awk '{print $1}')

# Install GNU Stow
sudo pacman -S stow

# Install dotfiles
./install.sh
```

## 🔧 Post-Installation

1. **Restart your terminal** for Zsh changes to take effect
2. **Log out and back in** for Hyprland changes
3. **Restart applications** for config changes

## ✨ Features

- **Window Manager**: Hyprland with custom configuration
- **Status Bar**: Waybar with custom modules
- **Terminal**: Kitty with custom theme and configuration
- **Application Launcher**: Rofi (Wayland) with custom theme
- **Notification Daemon**: SwayNC
- **Logout Screen**: Wlogout
- **Text Editor**: Neovim with LazyVim configuration
- **Shell**: Zsh with custom configuration
- **File Manager**: Thunar
- **Browser**: Firefox, Zen Browser
- **System Monitor**: Btop, Htop

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

## 🚨 Troubleshooting

- **Permission denied**: Run `chmod +x install.sh`
- **Package conflicts**: Update with `sudo pacman -Sy`
- **Stow conflicts**: Remove existing configs first
- **AUR packages fail**: Install yay first: `sudo pacman -S yay`

## 📚 More Information

- Run `./test-install.sh` to verify your setup
- Use `make help` for available commands

## 📋 Prerequisites

- Arch Linux system
- `sudo` access
- Internet connection

## 📚 Configuration Structure

```
dotfiles/
├── hypr/                 # Hyprland configuration
├── waybar/               # Waybar status bar
├── kitty/                # Terminal configuration
├── rofi/                 # Application launcher
├── wlogout/              # Logout screen
├── wofi/                 # Alternative launcher
├── fastfetch/            # System information
├── nvim/                 # Neovim configuration
├── zshrc/                # Zsh configuration
├── wallpapers/           # Wallpaper collection
├── packages/             # Package lists
│   ├── pkglist.txt       # Official packages
│   └── aur-installed.txt # AUR packages
├── install.sh            # Installation script
└── README.md             # This file
```

For more detailed documentation, see the individual configuration directories.
