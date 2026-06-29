# Fuzzy find and install packages (AUR + official repos)
function inst
    set -l packages (yay -Slq | sort | fzf --preview 'yay -Si {}' \
        --preview-window=right:60%:wrap \
        --header='Select package to install (Tab for multi-select)' \
        --multi)
    if test (count $packages) -gt 0
        echo "Installing: $packages"
        yay -S --noconfirm --needed -- $packages
    else
        echo "No packages selected."
    end
end

# Fuzzy find and uninstall packages
function uninst
    set -l packages (yay -Qq | fzf --preview 'yay -Qi {}' \
        --preview-window=right:60%:wrap \
        --header='Select package to remove (Tab for multi-select)' \
        --multi)
    if test (count $packages) -gt 0
        echo "Removing: $packages"
        yay -R -- $packages
    end
end

# Remove with dependencies
function uninstall-all
    set -l packages (yay -Qq | fzf --preview 'yay -Qi {}' \
        --preview-window=right:60%:wrap \
        --header='Select package to remove with deps (Tab for multi-select)' \
        --multi)
    if test (count $packages) -gt 0
        echo "Removing (with deps): $packages"
        yay -Rs -- $packages
    end
end

# Remove all orphaned packages
function clean-orphans
    set -l orphans (yay -Qdtq)
    if test (count $orphans) -gt 0
        echo "Removing orphans: $orphans"
        yay -Rns -- $orphans
    else
        echo "No orphaned packages 🎉"
    end
end

# Search only: fuzzy browse packages with preview
function search
    yay -Slq --sortby name | fzf --preview 'yay -Si {}' \
        --preview-window=right:60%:wrap \
        --header='Browse packages (Esc to quit, Enter shows details)'
end

# Update
function update
    echo "Checking for updates..."
    yay --noconfirm --needed
    and sudo pacman -Syu
    and paccache -r
    and echo "Done - Press enter to exit"
    and read
    and pkill -SIGRTMIN+8 waybar
end
