#!/usr/bin/env zsh

# Fuzzy find and install packages (AUR + official repos)
install() {
    yay -Slq --sortby name | \
    fzf --preview 'yay -Si {}' \
        --preview-window=right:60%:wrap \
        --header='Select package to install (Tab for multi-select)' \
        --multi | \
    xargs -r yay -S
}

# Fuzzy find and uninstall packages
uninstall() {
    local packages
    packages=$(yay -Qq | \
        fzf --preview 'yay -Qi {}' \
            --preview-window=right:60%:wrap \
            --header='Select package to remove (Tab for multi-select)' \
            --multi)
    
    [[ -n "$packages" ]] && echo "$packages" | xargs yay -R || true
}

# Remove with dependencies (orphans)
uninstall-all() {
    local packages
    packages=$(yay -Qq | \
        fzf --preview 'yay -Qi {}' \
            --preview-window=right:60%:wrap \
            --header='Select package to remove with deps (Tab for multi-select)' \
            --multi)
    
    [[ -n "$packages" ]] && echo "$packages" | xargs yay -Rs || true
}
