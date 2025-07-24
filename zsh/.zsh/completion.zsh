# https://zsh.sourceforge.io/Doc/Release/Options.html#Completion-4

# path for completions
# fpath=(~/.zsh/completion $fpath)

# zsh completion
autoload -Uz compinit && compinit

# menu for completion
zstyle ':completion:*' menu select

# disable case sensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# enable colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
