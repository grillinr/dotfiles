# Arch Linux Dotfiles

This repository contains my Arch Linux dotfiles and configuration files, managed using `stow` for easy installation and maintenance.

## Features

- **Window Manager**: Hyprland with custom configuration
- **Status Bar**: Waybar with custom modules
- **Terminal**: Kitty with custom theme and configuration
- **Application Launcher**: Rofi (Wayland) with custom theme
- **Notification Daemon**: SwayNC
- **Logout Screen**: Wlogout
- **File Manager**: Thunar
- **Text Editor**: Neovim with LazyVim configuration
- **Shell**: Zsh with custom configuration
- **System Monitor**: Btop, Htop
- **Media Player**: MPV
- **Browser**: Firefox, Zen Browser
- **Development**: Visual Studio Code, Git, GitHub CLI
- **And much more...**

## Installation

### Prerequisites

- Arch Linux system
- `sudo` access
- Internet connection

### Quick Install

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the installation script**:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

The script will:
- Install all required packages from official repositories and AUR
- Backup existing dotfiles
- Symlink all configuration files using `stow`
- Enable necessary system services
- Add user to required groups

### Manual Installation

If you prefer to install manually:

1. **Install packages**:
   ```bash
   # Install official packages
   sudo pacman -S --needed $(cat packages/package-list.txt)
   
   # Install AUR packages (requires yay)
   yay -S --needed $(cat packages/aur-packages.txt)
   ```

2. **Install stow**:
   ```bash
   sudo pacman -S stow
   ```

3. **Symlink dotfiles**:
   ```bash
   # From the dotfiles directory
   stow hypr waybar kitty rofi swaync wlogout wofi fastfetch nvim zshrc wallpapers
   ```

## Configuration Structure

```
dotfiles/
├── hypr/                 # Hyprland configuration
├── waybar/               # Waybar status bar
├── kitty/                # Terminal configuration
├── rofi/                 # Application launcher
├── swaync/               # Notification daemon
├── wlogout/              # Logout screen
├── wofi/                 # Alternative launcher
├── fastfetch/            # System information
├── nvim/                 # Neovim configuration
├── zshrc/                # Zsh configuration
├── wallpapers/           # Wallpaper collection
├── packages/             # Package lists
│   ├── package-list.txt  # Official packages
│   └── aur-packages.txt  # AUR packages
├── install.sh            # Installation script
└── README.md             # This file
```

## Package Management

### Adding Packages

1. **Official packages**: Add to `packages/package-list.txt`
2. **AUR packages**: Add to `packages/aur-packages.txt`
3. **Re-run installation**: `./install.sh`

### Updating Packages

```bash
# Update system packages
sudo pacman -Syu

# Update AUR packages
yay -Syu
```

## Dotfiles Management

### Using Stow

```bash
# Symlink a specific package
stow <package-name>

# Remove symlinks for a package
stow -D <package-name>

# Restow (remove and re-symlink)
stow -R <package-name>
```

### Adding New Configurations

1. Create a new directory for your configuration
2. Structure it to match your home directory layout
3. Add it to the `stow` command in `install.sh`
4. Run `stow <new-package-name>`

## Services

The installation script enables these services:
- NetworkManager
- Bluetooth
- SDDM (display manager)
- Pipewire (audio)
- Wireplumber (audio session manager)

## User Groups

The script adds your user to these groups:
- audio, video, input
- wheel (for sudo)
- network, storage, optical
- lp, scanner, power
- adbusers, docker, libvirt

## Customization

### Hyprland
- Configuration: `~/.config/hypr/`
- Keybinds: `~/.config/hypr/configs/keybinds.conf`
- Window rules: `~/.config/hypr/configs/windowrules.conf`

### Waybar
- Configuration: `~/.config/waybar/config`
- Style: `~/.config/waybar/style.css`

### Neovim
- Configuration: `~/.config/nvim/`
- Uses LazyVim as the base configuration

### Zsh
- Configuration: `~/.zshrc`
- Includes custom aliases and functions

## Troubleshooting

### Common Issues

1. **Missing packages**: Ensure all packages are installed
2. **Permission issues**: Check user groups and file permissions
3. **Service not starting**: Check service status with `systemctl status <service>`
4. **Configuration not loading**: Verify symlinks with `ls -la ~/.config/`

### Getting Help

- Check service status: `systemctl status <service>`
- View logs: `journalctl -u <service>`
- Check package installation: `pacman -Q <package>`
- Verify symlinks: `ls -la ~/.config/`

## Backup and Restore

The installation script automatically backs up existing dotfiles to `~/.dotfiles-backup-<timestamp>/`.

To restore from backup:
```bash
cp -r ~/.dotfiles-backup-<timestamp>/* ~/
```

## Contributing

Feel free to modify these configurations to better suit your needs. The modular structure makes it easy to customize individual components.

## License

This configuration is provided as-is for personal use. Feel free to adapt it for your own needs.