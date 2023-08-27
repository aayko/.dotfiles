export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export MANPAGER='nvim +Man!'

export ZSH=$HOME/.config/zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
source $ZSH/catppuccin_mocha-zsh-syntax-highlighting.zsh

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "jeffreytse/zsh-vi-mode"
plug "zsh-users/zsh-syntax-highlighting"
plug "unixorn/fzf-zsh-plugin"

source $ZSH/aliases.zsh

# VIA caps lock remap
# MT(MOD_LCTL,KC_ESC)

#don't add failed command to ~/.zsh_history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

zle_highlight=('paste:none')
unsetopt BEEP
stty ixany

export FZF_DEFAULT_COMMAND="find -L"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--height 40%
--preview-window=:hidden"

function fnvim() {
    local selected_file
    cd "$HOME"
    selected_file="$(fzf)"
    if [ -n "$selected_file" ]; then
        nvim "$selected_file"
    else
        cd -
    fi
}

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

# Paste last command output
zmodload -i zsh/parameter

insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output

bindkey "^x" insert-last-command-output
bindkey "^o" fzf-cd-widget
bindkey -s "^T" "lfcd^Mclear^M"
bindkey -s "^v" "fnvim^M"

# ------ PROMPT ------
__git_files () { 
    _wanted files expl 'local files' _files     
}

function is_dirty {
    [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

function set_prompt {
    local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
    local dirty_status="$(is_dirty)"

    local git_info=""
    if [ -n "$branch_name" ]; then
        git_info="%F{green}$branch_name$dirty_status "
    fi

    PS1="%F{blue}%~ $git_info%f> "
}

precmd() {
    set_prompt
}

autoload -Uz compinit
compinit
