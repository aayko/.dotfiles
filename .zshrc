source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "jeffreytse/zsh-vi-mode"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source ~/.ssh-web

function lfcd () {
    tmp="$(mktemp)"
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

bindkey -s "^o" "lfcd^M"

alias lf="lfcd"

alias v="nvim"
alias vim="nvim"

alias mkdir="mkdir -vp"
# alias rm="rm -v"
alias rm="trash-put"
alias srm="sudo trash-put"
alias cp="cp -v"
alias mv="mv -v"

alias grep='grep --color=always'
alias ls="lsd -A --group-directories-first --sort=extension"
alias tree="lsd -A --depth=2 --tree --group-directories-first --sort=extension"

alias py="clear && python3"
alias se="sudoedit"
alias dot="~/.config"
alias p="sudo pacman"
alias cat="bat"

alias :q="exit"
alias so="clear && exec zsh"
# alias empty-trash="sudo rm -rf ~/.local/share/Trash/*"

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git 

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{%F{blue}%}%m%c%{%F{green}%}*%b%f"

# PROMPT='%F{blue}%~ %F{green}$(git_prompt_info)%f > '
PROMPT="%F{blue}%~\$vcs_info_msg_0_%f > "
# PROMPT+="\$vcs_info_msg_0_ "

# ZSH_THEME_GIT_PROMPT_PREFIX=""
# ZSH_THEME_GIT_PROMPT_SUFFIX=""
#
# is_git_repo() {
#   git rev-parse --is-inside-work-tree >/dev/null 2>&1
# }
#
# update_prompt() {
#   if is_git_repo; then
#     PROMPT='%F{blue}%~ %F{green}$(git_prompt_info)%f > '
#   else
#     PROMPT='%F{blue}%~ > '
#   fi
# }
#
# precmd() {
#   update_prompt
# }

#don't add failed command to ~/.zsh_history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

path+=('/home/ayko/.local/share/gem/ruby/3.0.0/bin')
path+=('/home/ayko/.cargo/bin')
export PATH
export PATH=$PATH:/home/ayko/.spicetify

# Load and initialise completion system
autoload -Uz compinit
compinit
