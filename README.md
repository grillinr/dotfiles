# NixOS Configuration

This is a NixOS configuration generated from your Arch Linux dotfiles repository. It replicates your current setup using NixOS and Home Manager.

## Features

- **Hyprland** window manager with your custom configuration
- **Waybar** status bar with your custom styling
- **Kitty** terminal with your theme and settings
- **Neovim** with LazyVim configuration
- **Rofi** application launcher
- **SwayNC** notification center
- **Wlogout** logout screen
- **Wofi** alternative launcher
- **Fastfetch** system information
- **Zsh** shell with Powerlevel10k theme
- All your custom scripts and configurations
- Wallpapers and themes

## Installation

1. **Install NixOS** on your system
2. **Clone this repository** to `/etc/nixos/`:
   ```bash
   sudo git clone <your-repo-url> /etc/nixos/
   cd /etc/nixos/
   ```

3. **Update hardware configuration**:
   - Run `sudo nixos-generate-config` to generate a new `hardware-configuration.nix`
   - Replace the UUIDs in the generated file with your actual disk UUIDs

4. **Build and switch to the configuration**:
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

## Usage

### Building the system
```bash
# Build and switch to the configuration
sudo nixos-rebuild switch --flake .#nixos

# Build without switching (dry run)
sudo nixos-rebuild build --flake .#nixos

# Build and boot (for next boot)
sudo nixos-rebuild boot --flake .#nixos
```

### Updating the system
```bash
# Update flake inputs
nix flake update

# Rebuild with updated inputs
sudo nixos-rebuild switch --flake .#nixos
```

### Home Manager
```bash
# Apply Home Manager configuration
home-manager switch --flake .#nixos

# Update Home Manager
home-manager switch --flake .#nixos --impure
```

## Configuration Structure

- `flake.nix` - Main flake configuration with inputs
- `configuration.nix` - System-level NixOS configuration
- `hardware-configuration.nix` - Hardware-specific configuration
- `home.nix` - Home Manager user configuration
- `README.md` - This documentation

## Customization

### Adding packages
Add packages to either:
- `environment.systemPackages` in `configuration.nix` for system-wide packages
- `home.packages` in `home.nix` for user-specific packages

### Modifying configurations
- System configurations: Edit `configuration.nix`
- User configurations: Edit `home.nix`
- Dotfiles: The configuration automatically links your existing dotfiles

### Adding new dotfiles
Add new dotfile mappings to the `home.file` section in `home.nix`:
```nix
home.file = {
  ".config/myapp/config.conf".source = ./myapp/.config/myapp/config.conf;
};
```

## Troubleshooting

### Common issues

1. **Hardware configuration**: Make sure to update UUIDs in `hardware-configuration.nix`
2. **Missing packages**: Check if packages are available in nixpkgs
3. **Configuration errors**: Use `nixos-rebuild build` to test before switching

### Getting help
- Check NixOS manual: `man configuration.nix`
- NixOS wiki: https://nixos.wiki/
- Home Manager manual: https://nix-community.github.io/home-manager/

## Migration from Arch Linux

This configuration replicates your Arch Linux setup. Key differences:

- **Package management**: Uses Nix instead of pacman/yay
- **Configuration**: Declarative configuration instead of imperative
- **Reproducibility**: Entire system is reproducible from configuration
- **Rollbacks**: Easy system rollbacks with `nixos-rebuild switch --rollback`

## Notes

- The configuration includes all packages from your `package-list.txt`
- AUR packages are replaced with nixpkgs equivalents where available
- Some packages may need to be built from source or found in other flakes
- The configuration is optimized for your hardware setup

## Contributing

Feel free to modify this configuration to better suit your needs. The declarative nature of NixOS makes it easy to experiment and rollback changes.