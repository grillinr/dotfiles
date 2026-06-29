# Dotfiles Repository Agent Guidelines

This document outlines the architectural standards, code style, and operational procedures for this dotfiles repository. Agents and developers must adhere to these guidelines to ensure consistency across the configuration management system.

## 1. Repository Structure & Architecture

This repository uses **GNU Stow** to manage dotfiles. Each top-level directory (e.g., `nvim`, `hypr`, `zshrc`) represents a package that can be stowed into the user's home directory.

### Directory Pattern
- **Stow Packages:** Top-level folders are stow packages.
- **Config Mirroring:** Inside a package, the directory structure mirrors the target path relative to `$HOME`.
  - Example: `nvim/.config/nvim/` maps to `~/.config/nvim/`.
  - Example: `zshrc/.zshrc` maps to `~/.zshrc`.
- **Special Directories:**
  - `packages/`: Contains package lists (`pkglist.txt`, `aur-installed.txt`) for `pacman` and `yay`.
  - `scripts/`: (If present) contains helper scripts not managed by stow.

### Build & Deployment
- **No Build Step:** This is a configuration repo; there is no compilation.
- **Installation:** The primary entry point is `./install.sh`.
  - **Usage:** `./install.sh` (Installs packages and stows dotfiles).
  - **Mechanism:** It installs `git`, `stow`, `pacman` packages, `yay` packages (AUR), and then runs `stow`.
  - **Idempotency:** Scripts should be idempotent where possible.

### Submodules & Git
- **Caution:** Be aware of potential submodule irregularities (e.g., inside `yazi/`).
- **Check:** Always verify `.git` status when moving or adding configuration directories to ensure they aren't nested repositories.

## 2. Code Style & Conventions

### Shell Scripting (Bash)
- **Interpreter:** Use `#!/bin/bash`.
- **Safety:** Use strict mode where feasible, or at minimum check for errors (`set -e`).
- **Output:** Use colored output helpers consistent with `install.sh`.
  ```bash
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  BLUE='\033[0;34m'
  NC='\033[0m'
  
  print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
  print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
  print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
  ```
- **Naming:**
  - Variables: `UPPER_CASE` for globals/constants, `snake_case` for locals.
  - Functions: `snake_case`.
- **Linting:** Code should pass `shellcheck` recommendations.

### Lua (Neovim Config)
- **Formatter:** Strictly adhere to `nvim/.config/nvim/stylua.toml`.
  - Indent type: **Spaces**
  - Indent width: **2**
  - Column width: **120**
- **Naming:**
  - Files: `lowercase.lua` or `kebab-case.lua` (e.g., `goto-preview.lua`).
  - Locals: `snake_case` or `camelCase` (follow surrounding context).
- **LazyVim:** The configuration is based on LazyVim. Respect the `lua/plugins/*.lua` structure where each file returns a table (spec).

### Config Files (TOML, JSONC, Conf)
- **Hyprland:** (`.conf`)
  - Use `#` for comments.
  - Group related settings with comments.
- **Waybar:** (`.jsonc`)
  - Valid JSON with comments allowed.
  - Use `style.css` for styling, following standard CSS syntax.
- **General:**
  - Prefer explicit keys and values.
  - Align assignments where it improves readability.

## 3. Testing & Verification

Since this is a config repo, "testing" is manual verification or syntax checking.

### Syntax Checking
- **Lua:** `stylua --check nvim/.config/nvim/`
- **Shell:** `shellcheck install.sh`
- **Hyprland:** Run `hyprctl reload` to verify config validity (if running in Hyprland).

### Running "Tests"
To verify changes to a specific configuration:
1. **Apply:** Ensure the file is stowed correctly (`stow -R <package>`).
2. **Reload:** Restart the specific service or application.
  - **Waybar:** `pkill waybar && waybar &` or use `refresh.sh`.
  - **Hyprland:** `hyprctl reload`.
  - **Neovim:** Restart `nvim`.
  - **Zsh:** `source ~/.zshrc`.

## 4. Development Workflow

1. **Locate:** Identify the correct stow package (e.g., `waybar`).
2. **Edit:** Modify the file within the repository structure (e.g., `waybar/.config/waybar/config.jsonc`).
   - *Do not* edit the file in `~/.config/` directly; it is a symlink.
3. **Verify:**
   - Check syntax.
   - Reload the application.
4. **Commit:**
   - Messages should be descriptive: `feat(waybar): add battery module` or `fix(nvim): correct lsp indent`.

## 5. Tool-Specific Rules

### Neovim
- **Plugins:** managed via `lazy.nvim` in `lua/plugins/`.
- **LSP:** Configured via `mason` and `lspconfig`. Do not manually install LSP binaries; let Mason handle it.

### Hyprland
- **Monitors:** Monitor config is in `hyprland.conf` or included files.
- **Keybinds:** Use `bind = MOD, key, dispatcher, arg` syntax.

### Waybar
- **Scripts:** Custom scripts reside in `scripts/`. Ensure they are executable (`chmod +x`).
- **Style:** Edit `style.css` for visual changes.

## 6. Error Handling

- **Scripts:** All scripts must handle dependencies gracefully.
  - Check if a command exists before using it (`command -v cmd`).
  - Provide clear error messages using the color helpers.
  - Exit with non-zero status code on failure (`exit 1`).

## 7. Documentation

- **README:** If adding a new top-level package, update the main `README.md` (if it lists components).
- **Comments:** Comment complex logic in shell scripts or obscure config settings (e.g., "Why is this sleep here?").
