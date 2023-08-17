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

source $ZSH/aliases.zsh

# VIA caps lock remap
# MT(MOD_LCTL, KC_ESC)

#don't add failed command to ~/.zsh_history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

zle_highlight=('paste:none')
unsetopt BEEP
stty ixany

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

export FZF_DEFAULT_COMMAND="find -L"

function fzf_cd() {
    cd $HOME && cd "$(fd -t d --hidden | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}

function fzf_nvim() {
    local selected_file
    selected_file="$(fzf)"
    if [ -n "$selected_file" ]; then
        cd "$HOME" && nvim "$selected_file"
    fi
}

bindkey -s "^e" "lfcd^M"
bindkey -s "^o" "fzf_cd^M"
bindkey -s "^v" "fzf_nvim^M"

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
# ------ PATH ------
path+=('/home/ayko/.local/share/gem/ruby/3.0.0/bin')
path+=('/home/ayko/.cargo/bin')
path+=('/home/ayko/.spicetify')

autoload -Uz compinit
compinit
