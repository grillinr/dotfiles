# NixOS Migration Guide

This document explains how to migrate from your current Arch Linux setup to NixOS using the generated configuration.

## What's Included

Your NixOS configuration includes:

### System Configuration (`configuration.nix`)
- **Boot**: GRUB with EFI support
- **Networking**: NetworkManager
- **Audio**: PipeWire with ALSA and PulseAudio support
- **Graphics**: OpenGL with hardware acceleration
- **Bluetooth**: Full Bluetooth support with Blueman
- **Power Management**: TLP, auto-cpufreq, powertop
- **File Systems**: Btrfs support, zram swap
- **Services**: All necessary system services

### User Configuration (`home.nix`)
- **Shell**: Zsh with Powerlevel10k, FZF, eza, bat
- **Terminal**: Kitty with your custom theme
- **Window Manager**: Hyprland with your configuration
- **Status Bar**: Waybar with your custom styling
- **Applications**: Rofi, SwayNC, Wlogout, Wofi
- **Editor**: Neovim with LazyVim
- **System Info**: Fastfetch
- **All your dotfiles**: Automatically linked from your repository

### Packages Included
All packages from your `package-list.txt` are included:
- Development tools (Git, Go, Node.js, Python, Rust, TypeScript)
- System utilities (htop, btop, brightnessctl, etc.)
- Audio/Video tools (mpv, pavucontrol, etc.)
- Desktop applications (Firefox, Discord, Spotify, etc.)
- Fonts (All Nerd Fonts variants you had)
- GTK themes and tools

## Installation Process

### 1. Install NixOS
First, install NixOS on your system using the official installer.

### 2. Clone and Install Configuration
```bash
# Clone your dotfiles repository
sudo git clone <your-repo-url> /etc/nixos/
cd /etc/nixos/

# Run the installation script
./install.sh
```

### 3. Update Hardware Configuration
The script will generate a `hardware-configuration.nix` file. You need to:
1. Update the UUIDs to match your actual disk partitions
2. Review and adjust any hardware-specific settings

### 4. Build and Switch
```bash
# Test the configuration
sudo nixos-rebuild build --flake .#nixos

# Apply the configuration
sudo nixos-rebuild switch --flake .#nixos
```

## Key Differences from Arch Linux

### Package Management
- **Arch**: `pacman -S package`, `yay -S package`
- **NixOS**: Packages are declared in configuration files

### Configuration
- **Arch**: Manual configuration files, imperative setup
- **NixOS**: Declarative configuration, reproducible setup

### Updates
- **Arch**: `sudo pacman -Syu`
- **NixOS**: `nix flake update && sudo nixos-rebuild switch --flake .#nixos`

### Rollbacks
- **Arch**: Manual backup/restore
- **NixOS**: `sudo nixos-rebuild switch --rollback`

## Customization

### Adding Packages
Add to `environment.systemPackages` in `configuration.nix`:
```nix
environment.systemPackages = with pkgs; [
  # existing packages...
  new-package
];
```

### Adding User Packages
Add to `home.packages` in `home.nix`:
```nix
home.packages = with pkgs; [
  # existing packages...
  new-user-package
];
```

### Modifying Dotfiles
Your dotfiles are automatically linked. To modify:
1. Edit the source files in your dotfiles repository
2. Rebuild: `sudo nixos-rebuild switch --flake .#nixos`

### Adding New Dotfiles
Add to `home.file` in `home.nix`:
```nix
home.file = {
  # existing files...
  ".config/newapp/config.conf".source = ./newapp/.config/newapp/config.conf;
};
```

## Useful Commands

### System Management
```bash
# Apply configuration
sudo nixos-rebuild switch --flake .#nixos

# Apply on next boot
sudo nixos-rebuild boot --flake .#nixos

# Test configuration
sudo nixos-rebuild build --flake .#nixos

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Flake Management
```bash
# Update flake inputs
nix flake update

# Show flake inputs
nix flake show

# Show available packages
nix search nixpkgs package-name
```

### Home Manager
```bash
# Apply Home Manager configuration
home-manager switch --flake .#nixos

# Update Home Manager
home-manager switch --flake .#nixos --impure
```

### Package Management
```bash
# Search for packages
nix search nixpkgs package-name

# Install package temporarily
nix-shell -p package-name

# Show package information
nix show-derivation nixpkgs#package-name
```

## Troubleshooting

### Common Issues

1. **Hardware not detected**: Update `hardware-configuration.nix`
2. **Missing packages**: Check if available in nixpkgs or other flakes
3. **Configuration errors**: Use `nixos-rebuild build` to test
4. **Boot issues**: Use GRUB menu to select previous generation

### Getting Help
- NixOS Manual: `man configuration.nix`
- NixOS Wiki: https://nixos.wiki/
- Home Manager Manual: https://nix-community.github.io/home-manager/
- NixOS Discourse: https://discourse.nixos.org/

### Recovery
If your system doesn't boot:
1. Boot from NixOS installer
2. Mount your root partition
3. Run `nixos-rebuild switch --flake .#nixos` from the mounted system

## Benefits of NixOS

1. **Reproducibility**: Entire system defined in configuration
2. **Rollbacks**: Easy system rollbacks
3. **Atomic Updates**: Updates are atomic and safe
4. **Declarative**: System state is declared, not achieved
5. **Isolation**: Packages are isolated and don't conflict
6. **Reproducible Builds**: Same configuration always produces same result

## Next Steps

1. **Test the configuration** thoroughly
2. **Customize** as needed for your specific hardware
3. **Learn Nix** to make advanced customizations
4. **Contribute** improvements back to the community

Your NixOS configuration is now ready to provide a robust, reproducible, and maintainable system that replicates your Arch Linux setup with all the benefits of NixOS!

