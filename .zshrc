# DISABLE_AUTO_TITLE="true"

# Change emulator title to wd
# case $TERM in xterm*)
#     precmd () {print -Pn "\e]0;%1~\a"}
#     ;;
# esac

# VIA caps lock remap
# MT(MOD_LCTL, KC_ESC)

#don't add failed command to ~/.zsh_history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export ZSH=$HOME/.oh-my-zsh

source $HOME/.ssh-web
source $HOME/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

plugins=(
    zsh-autosuggestions 
    zsh-syntax-highlighting
    zsh-vi-mode
)
source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh/aliases.zsh

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

zle_highlight=('paste:none')
unsetopt BEEP
stty ixany

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

bindkey -s "^o" "lfcd^M"

# ------ PROMPT ------
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

is_git_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

update_prompt() {
  if is_git_repo; then
    PROMPT='%F{blue}%~ %F{green}$(git_prompt_info)%f > '
  else
    PROMPT='%F{blue}%~%f > '
  fi
}

precmd() {
  update_prompt
}

# ------ PATH ------
path+=('/home/ayko/.local/share/gem/ruby/3.0.0/bin')
path+=('/home/ayko/.cargo/bin')
path+=('/home/ayko/.spicetify')
