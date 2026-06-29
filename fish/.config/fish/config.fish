if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Replace built in shells commands
alias ls='eza -G --icons'
alias lsa='eza -Ga --icons'
alias lsla='eza -1la --icons'
alias lsl='eza -Gl --icons'
alias lst='eza --tree --level=1 --icons'
alias cd="z"
alias grep='grep --color=auto'
alias lg="lazygit"

# Package management shortcuts
alias install-man='yay -S'
alias uninstall-man='yay -Rns'
alias pacup='sudo pacman -Rns $(pacman -Qdtq)'

# Directory shortcuts
alias hypr='cd /home/nathan/.config/hypr; nvim .'
alias school='cd /home/nathan/repos/school/25FS/'
alias nq='cd /home/nathan/repos/nq; nvim .'
alias start-nq='npx concurrently --names "backend,frontend"  "cd ~/repos/nq/backend && go run ." "cd ~/repos/nq/frontend && npm start"'
alias startnq='npx concurrently --names backend,frontend "cd ~/repos/nq/backend && go run ." "cd ~/repos/nq/nq-frontend && npx expo start --tunnel"'

# Helphul commands
alias pool='clear && asciiquarium'
alias fonts='fc-list -f "%{family}\n"'
alias tasks='bpytop'
alias viruscheck='sudo clamscan -r /'
alias spot="ncspot"
alias connect="ssh ssh.nathangrilliot.com"
alias diskinfo='df -h'
alias gqlgen='go run github.com/99designs/gqlgen generate'
alias about='fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc'
alias n='nvim .'
alias oc='opencode'

zoxide init fish | source

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end
