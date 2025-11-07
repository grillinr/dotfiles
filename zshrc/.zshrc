# git repository greeter
# last_repository=
# check_directory_for_new_repository() {
#  current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
#
#  if [ "$current_repository" ] && \
#     [ "$current_repository" != "$last_repository" ]; then
#   onefetch --include-hidden --nerd-fonts
#  fi
#  last_repository=$current_repository
# }
# cd() {
#  builtin cd "$@"
#  check_directory_for_new_repository
# }

# optional, greet also when opening shell directly in repository directory
# adds time to startup
# check_directory_for_new_repository

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    kitty
)

source $ZSH/oh-my-zsh.sh
source "$HOME/.config/hypr/obscure-scripts/package_management.sh"

# Replace built in sheels commands
alias ls='eza -1 --icons'
alias la='eza -1a --icons'
alias lla='eza -1la --icons'
alias ll='eza -1l --icons'
alias lt='eza --tree --level=1 --icons'
alias cd="z"
alias grep='grep --color=auto'
alias lg="lazygit"

# Package management shortcuts
alias install-man='yay -S'
alias uninstall-man='yay -Rns'
alias pacup='sudo pacman -Rns $(pacman -Qdtq)'
alias update="yay; sudo pacman -Syu; paccache -r; echo Done - Press enter to exit; read; pkill -SIGRTMIN+8 waybar"

# Directory shortcuts
alias hypr='cd /home/nathan/.config/hypr; nvim .'
alias school='cd /home/nathan/repos/school/25FS/'
alias nq='cd /home/nathan/repos/nq; nvim .'
alias start-nq='npx concurrently --names "backend,frontend"  "cd ~/repos/nq/backend && go run ." "cd ~/repos/nq/nq-frontend && npm start"'

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

# Yazi functions
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

export PATH=$PATH:/home/nathan/.spicetify
export PATH=$PATH:/home/nathan/.cargo/bin
export EDITOR=nvim

# Load Angular CLI autocompletion.
# source <(ng completion script)

# Created by `pipx` on 2025-02-04 14:54:31
export PATH="$PATH:/home/nathan/.local/bin"
eval "$(zoxide init zsh)"

# opencode
export PATH=/home/nathan/.opencode/bin:$PATH
