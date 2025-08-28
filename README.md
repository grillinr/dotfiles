# Dotfiles

My personal dotfiles configuration for Arch Linux, featuring a Hyprland-based setup with various tools and applications.

## Features

- **Hyprland** - Modern Wayland compositor
- **Kitty** - Fast, feature-rich terminal emulator
- **Neovim** - Enhanced Vim with Lua configuration
- **Waybar** - Customizable status bar
- **Rofi** - Application launcher
- **Swaync** - Notification daemon
- **Wlogout** - Logout screen
- **Fastfetch** - System information display
- **Zsh** - Enhanced shell configuration

## Quick Install

### Prerequisites

- Arch Linux (or Arch-based distribution)
- `sudo` access
- Internet connection

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/dotfiles.git
   cd dotfiles
   ```

2. **Run the install script:**
   ```bash
   ./install.sh
   ```

The script will:
- Install all required packages from `packages/package-list.txt`
- Install AUR packages from `packages/aur-packages.txt` (if yay is available)
- Install GNU Stow if not present
- Backup any existing configurations
- Install all dotfiles using GNU Stow
- Set up wallpapers and additional configurations

## Manual Installation

If you prefer to install manually or want to customize the process:

### 1. Install Required Packages

```bash
# Install base packages
sudo pacman -S --needed $(cat packages/package-list.txt)

# Install AUR packages (requires yay)
yay -S --needed $(cat packages/aur-packages.txt)
```

### 2. Install GNU Stow

```bash
sudo pacman -S stow
```

### 3. Install Dotfiles

```bash
# Install all configurations
stow -t $HOME nvim
stow -t $HOME kitty
stow -t $HOME waybar
stow -t $HOME rofi
stow -t $HOME swaync
stow -t $HOME wlogout
stow -t $HOME wofi
stow -t $HOME hypr
stow -t $HOME fastfetch
stow -t $HOME zshrc
```

## Directory Structure

```
dotfiles/
├── install.sh              # Main installation script
├── packages/               # Package lists
│   ├── package-list.txt    # Official repository packages
│   └── aur-packages.txt    # AUR packages
├── nvim/                   # Neovim configuration
│   └── .config/nvim/
├── kitty/                  # Kitty terminal configuration
│   └── .config/kitty/
├── waybar/                 # Waybar status bar configuration
│   └── .config/waybar/
├── rofi/                   # Rofi launcher configuration
│   └── .config/rofi/
├── swaync/                 # Swaync notification configuration
│   └── .config/swaync/
├── wlogout/                # Wlogout configuration
│   └── .config/wlogout/
├── wofi/                   # Wofi launcher configuration
│   └── .config/wofi/
├── hypr/                   # Hyprland configuration
│   └── .config/hypr/
├── fastfetch/              # Fastfetch configuration
│   └── .config/fastfetch/
├── zshrc/                  # Zsh configuration
│   └── .zshrc
└── wallpapers/             # Wallpaper collection
    └── walls/
```

## Using GNU Stow

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) for managing dotfiles. Stow creates symlinks from your home directory to the configuration files in this repository.

### Basic Commands

```bash
# Install a configuration
stow -t $HOME <config-name>

# Uninstall a configuration
stow -D -t $HOME <config-name>

# Restow a configuration (useful after updates)
stow -R -t $HOME <config-name>
```

### Example

```bash
# Install Neovim configuration
stow -t $HOME nvim

# This creates symlinks like:
# ~/.config/nvim/init.lua -> ~/dotfiles/nvim/.config/nvim/init.lua
```

## Uninstalling

To remove all dotfiles:

```bash
# Remove all configurations
stow -D -t $HOME nvim
stow -D -t $HOME kitty
stow -D -t $HOME waybar
stow -D -t $HOME rofi
stow -D -t $HOME swaync
stow -D -t $HOME wlogout
stow -D -t $HOME wofi
stow -D -t $HOME hypr
stow -D -t $HOME fastfetch
stow -D -t $HOME zshrc
```

## Backup and Restore

The install script automatically creates backups of existing configurations in `~/.dotfiles_backup_YYYYMMDD_HHMMSS/`. You can restore from these backups if needed.

## Customization

### Adding New Configurations

1. Create a new directory with the appropriate structure:
   ```bash
   mkdir -p newapp/.config/newapp
   ```

2. Add your configuration files to the new directory

3. Add the directory to the `stow_dirs` array in `install.sh`

4. Run the install script again or manually stow:
   ```bash
   stow -t $HOME newapp
   ```

### Modifying Existing Configurations

1. Edit the configuration files in the appropriate directory
2. The changes will be immediately reflected due to symlinks
3. Commit and push your changes to version control

## Troubleshooting

### Common Issues

**Permission Denied:**
```bash
# Make sure the install script is executable
chmod +x install.sh
```

**Stow Conflicts:**
```bash
# If you get conflicts, remove existing configs first
rm -rf ~/.config/conflicting-app
stow -t $HOME app-name
```

**Package Installation Fails:**
```bash
# Update package database
sudo pacman -Sy

# Install packages individually to identify issues
sudo pacman -S package-name
```

### Getting Help

- Check the [Arch Wiki](https://wiki.archlinux.org/) for package-specific issues
- Review the [GNU Stow documentation](https://www.gnu.org/software/stow/)
- Check application-specific documentation for configuration issues

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the installation process
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [GNU Stow](https://www.gnu.org/software/stow/) for dotfile management
- The Arch Linux community for excellent documentation
- Various open-source projects that make this setup possible
