#PROMPT title
# DISABLE_AUTO_TITLE="true"

# Change emulator title to wd
# case $TERM in xterm*)
#     precmd () {print -Pn "\e]0;%1~\a"}
#     ;;
# esac

# VIA caps lock remap
# MT(MOD_LCTL, KC_ESC)

export ZSH="$HOME/.oh-my-zsh"

plugins=(
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting
    # zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh
source ~/.ssh-web

lfcd () {
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

alias lf="lfcd"

alias v="nvim"
alias vim="nvim"

alias mkdir="mkdir -vp"
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"

alias grep='grep --color=always'
alias ls="lsd -A --group-directories-first --sort=extension"
alias tree="lsd -A --depth=2 --tree --group-directories-first --sort=extension"

alias py="clear && python3"
alias se="sudoedit"
alias dot="~/.config"
alias p="sudo pacman"
alias xcolor="xclip -o -selection clipboard | xcolor | tee >(xclip -selection clipboard)"
alias cat="bat"

alias :q="exit"
alias so="clear && exec zsh"
alias trash-empty="sudo rm -rf ~/.local/share/Trash/*"

export THEME_DIR="/usr/local/share/themes/Catppuccin-Macchiato-Standard-Mauve-dark/gtk-4.0"
export GTK4_PATH="/home/ayko/.config/gtk-4.0"

alias empty-gtk4="sudo rm -rf \"$GTK4_PATH/assets\" \"$GTK4_PATH/gtk.css\" \"$GTK4_PATH/gtk-dark.css\""
alias update-theme="\
    empty-gtk4 \
    && sudo ln -s \"$THEME_DIR/assets\" \"$GTK4_PATH/assets\" \
    && sudo ln -s \"$THEME_DIR/gtk.css\" \"$GTK4_PATH/gtk.css\" \
    && sudo ln -s \"$THEME_DIR/gtk-dark.css\" \"$GTK4_PATH/gtk-dark.css\" \
    "

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

is_git_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

update_prompt() {
  if is_git_repo; then
    PROMPT='%F{blue}%~ %F{green}$(git_prompt_info)%f > '
  else
    PROMPT='%F{blue}%~ > '
  fi
}

precmd() {
  update_prompt
}

#don't add failed command to ~/.zsh_history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

path+=('/home/ayko/.local/share/gem/ruby/3.0.0/bin')
path+=('/home/ayko/.cargo/bin')
export PATH
