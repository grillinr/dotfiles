# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

fastfetch # -c $HOME/.config/fastfetch/config-compact.jsonc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# git repository greeter
last_repository=
check_directory_for_new_repository() {
 current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
 
 if [ "$current_repository" ] && \
    [ "$current_repository" != "$last_repository" ]; then
  onefetch --include-hidden
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


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

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
alias hypr='cd /home/nathan/.config/hypr'
alias install='yay -S'
alias uninstall='yay -Rns'
alias school='cd /home/nathan/repos/school'
alias pacup='sudo pacman -Rns $(pacman -Qdtq)'
alias grep='grep --color=auto'
alias pool='clear && asciiquarium'
alias fonts='fc-list -f "%{family}\n"'
alias hypr='cd ~/.config/hypr/'
alias tasks='bpytop'
alias viruscheck='sudo clamscan -r /'
alias spot="ncspot"
alias clear="clear && fastfetch"
alias connect="ssh ssh.nathangrilliot.com"
alias diskinfo='df -h'
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
