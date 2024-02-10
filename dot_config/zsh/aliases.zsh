alias dot="chezmoi"
alias lf="lfcd"

alias v="nvim"
alias se="sudoedit"

alias s="sudo"
alias please='sudo $(fc -ln -1)'

alias mkdir="mkdir -vp"
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"
alias diff="colordiff"

alias df="df -h"
alias free="free -m"

alias grep="grep --color=always"
alias ls="ls --color --group-directories-first"
alias ll="ls -lh --color --group-directories-first"
alias tree="tree -L 4"
alias ka="killall"
alias so="clear; exec zsh"

alias n="nix-env"

alias ssh-web="sshfs -o gid=1000,uid=1000,noauto,_netdev,reconnect,allow_other web:/www-dev/ ~/uni/web"
