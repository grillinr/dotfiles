# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# git repository greeter
last_repository=
check_directory_for_new_repository() {
 current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
 
 if [ "$current_repository" ] && \
    [ "$current_repository" != "$last_repository" ]; then
  onefetch --include-hidden --nerd-fonts
 fi
 last_repository=$current_repository
}
cd() {
 builtin cd "$@"
 check_directory_for_new_repository
}

# optional, greet also when opening shell directly in repository directory
# adds time to startup
check_directory_for_new_repository

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

# Set-up icons for files/folders in terminal
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias hypr='cd /home/nathan/.config/hypr; nvim .'
alias install='yay -S'
alias uninstall='yay -Rns'
alias school='cd /home/nathan/repos/school'
alias nq='cd /home/nathan/repos/nq; nvim .'
alias pacup='sudo pacman -Rns $(pacman -Qdtq)'
alias grep='grep --color=auto'
alias pool='clear && asciiquarium'
alias fonts='fc-list -f "%{family}\n"'
alias tasks='bpytop'
alias viruscheck='sudo clamscan -r /'
alias spot="ncspot"
alias connect="ssh ssh.nathangrilliot.com"
alias diskinfo='df -h'
alias gqlgen='go run github.com/99designs/gqlgen generate'
# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

export PATH=$PATH:/home/nathan/.spicetify
export PATH=$PATH:/home/nathan/.cargo/bin

# Load Angular CLI autocompletion.
# source <(ng completion script)

# Created by `pipx` on 2025-02-04 14:54:31
export PATH="$PATH:/home/nathan/.local/bin"
