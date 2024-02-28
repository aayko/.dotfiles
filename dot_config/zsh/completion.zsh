autoload -Uz plug

autoload -Uz compinit
zstyle ':completion:*' menu yes select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.
for dump in "${ZDOTDIR:-$HOME}/.zcompdump"(N.mw+1); do
  compinit
done
compinit -C
