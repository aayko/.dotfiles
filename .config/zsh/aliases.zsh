alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lf="lfcd"

alias e="nvim"
alias se="sudoedit"
alias epk="nvim ~/packages-list"

alias mkdir="mkdir -vp"
alias rmv="rm -v"
alias cp="cp -v"
alias mv="mv -v"

alias df='df -h'
alias free='free -m'

alias grep='grep --color=always'
alias ls="lsd -A --group-directories-first --sort=extension"
alias ll="lsd -Al --group-directories-first --sort=extension"
alias tree="lsd -A --depth=2 --tree --group-directories-first --sort=extension"
alias cat="bat"

alias p="sudo pacman"
alias py="clear && python3"
alias so="clear && exec zsh"

source $HOME/.ssh-web
