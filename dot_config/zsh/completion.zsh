autoload -Uz plug

# completions
autoload -Uz compinit
zstyle ':completion:*' menu yes select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
for dump in "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"(N.mw+1); do
  compinit
done
compinit -C
