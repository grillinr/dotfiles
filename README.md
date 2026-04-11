# Arch Linux Dotfiles

This repository contains my Arch Linux dotfiles with a Gruvbox theme and configuration files, managed using `stow` for easy installation and maintenance.

## Examples

![Desktop example](https://github.com/grillinr/dotfiles/blob/main/pictures/dotfile_example.png)

## Quick Installation

**ALWAYS READ SCRIPTS BEFORE RUNNING ON YOUR SYSTEM**

```bash
# Full install (packages + dotfiles)
curl -fsSL https://raw.githubusercontent.com/grillinr/dotfiles/main/install.sh | bash

# Dotfiles only (skip package install)
curl -fsSL https://raw.githubusercontent.com/grillinr/dotfiles/main/install.sh | bash -s -- --dotfiles

# Packages only (skip stow)
curl -fsSL https://raw.githubusercontent.com/grillinr/dotfiles/main/install.sh | bash -s -- --packages

# Dry run (show what would happen)
./install.sh --dry-run
```

## Installation

### Modes

| Flag | Action |
|------|--------|
| `--all` | Packages + dotfiles (default) |
| `--dotfiles` | Stow only, skip package install |
| `--packages` | Install packages only, skip stow |
| `--dry-run` | Show commands without executing |

## 🔧 Post-Installation

1. **Restart your terminal** for Zsh changes to take effect
2. **Log out and back in** for Hyprland changes
3. **Restart applications** for config changes

## Features

- **Window Manager**: Hyprland with custom configuration
- **Status Bar**: Waybar with custom modules
- **Terminal**: Kitty with custom theme and configuration
- **Application Launcher**: Rofi (Wayland) with custom theme
- **GTK Theming**: dconf + GTK3 settings (Andromeda-dark theme)
- **Notification Daemon**: SwayNC
- **Logout Screen**: Wlogout
- **Text Editor**: Neovim with LazyVim configuration
- **Shell**: Zsh with custom configuration
- **File Manager**: Thunar
- **Browser**: Firefox, Zen Browser
- **System Monitor**: Btop, Htop

## What Gets Installed

- **Neovim** - Enhanced Vim with Lua config
- **Kitty** - Fast terminal emulator
- **Waybar** - Customizable status bar
- **Rofi** - Application launcher
- **GTK Theming** - dconf + GTK3 settings
- **Swaync** - Notification daemon
- **Wlogout** - Logout screen
- **Wofi** - Alternative launcher
- **Hyprland** - Modern Wayland compositor
- **Fastfetch** - System information
- **Zsh** - Enhanced shell configuration
- **Wallpapers** - Collection of wallpapers

## Updating

```bash
# Pull latest changes
git pull origin main
# Reinstall dotfiles
./install.sh
```

## Troubleshooting

- **Permission denied**: Run `chmod +x install.sh`
- **Package conflicts**: Update with `sudo pacman -Sy`
- **Stow conflicts**: Remove existing configs first
- **AUR packages fail**: Install yay first: `sudo pacman -S yay`

## More Information

- Run `./test-install.sh` to verify your setup
- Use `make help` for available commands

## Prerequisites

- Arch Linux system
- `sudo` access
- Internet connection

## Configuration Structure

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
