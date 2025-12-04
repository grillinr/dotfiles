#!/usr/bin/env zsh

# Fuzzy find and install packages (AUR + official repos)
install() {
    local packages
    packages=("${(@f)$(yay -Slq --sortby name | \
        fzf --preview 'yay -Si {}' \
            --preview-window=right:60%:wrap \
            --header='Select package to install (Tab for multi-select)' \
            --multi)}")

    if (( ${#packages[@]} )); then
        echo "Installing: ${packages[@]}"
        yay -S -- "${packages[@]} --noconfirm --needed"
    fi
}

# Fuzzy find and uninstall packages
uninstall() {
    local packages
    packages=("${(@f)$(yay -Qq | \
        fzf --preview 'yay -Qi {}' \
            --preview-window=right:60%:wrap \
            --header='Select package to remove (Tab for multi-select)' \
            --multi)}")

    if (( ${#packages[@]} )); then
        echo "Removing: ${packages[@]}"
        yay -R -- "${packages[@]}"
    fi
}

# Remove with dependencies (orphans of those selected)
uninstall-all() {
    local packages
    packages=("${(@f)$(yay -Qq | \
        fzf --preview 'yay -Qi {}' \
            --preview-window=right:60%:wrap \
            --header='Select package to remove with deps (Tab for multi-select)' \
            --multi)}")

    if (( ${#packages[@]} )); then
        echo "Removing (with deps): ${packages[@]}"
        yay -Rs -- "${packages[@]}"
    fi
}

# Remove all orphaned packages (no selection, straight cleanup)
clean-orphans() {
    local orphans
    orphans=("${(@f)$(yay -Qdtq)}")

    if (( ${#orphans[@]} )); then
        echo "Removing orphans: ${orphans[@]}"
        yay -Rns -- "${orphans[@]}"
    else
        echo "No orphaned packages 🎉"
    fi
}

# Search only: fuzzy browse packages with preview, no install/remove
search() {
    yay -Slq --sortby name | \
        fzf --preview 'yay -Si {}' \
            --preview-window=right:60%:wrap \
            --header='Browse packages (Esc to quit, Enter shows details)'
}

# Update
update() {
    echo "Checking for updates..."
    yay --noconfirm --needed; sudo pacman -Syu; paccache -r; echo Done - Press enter to exit; read; pkill -SIGRTMIN+8 waybar
}
