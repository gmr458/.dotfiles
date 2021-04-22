autoload -Uz compinit && compinit

# Git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
#PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%F{11}%b%f'

PROMPT='%(?.%F{76}✓.%F{196}✗)%f '
PROMPT+='%B%F{14}%1~%f%b'
PROMPT+=' %F{%(?.76.196)}%#%f '

alias cls='clear'
alias md='mkdir'
alias ls='lsd --group-dirs first'
alias lsa='lsd -A --group-dirs first'
alias ll='lsd -lhS --blocks permission,group,size,date,name  --date relative --group-dirs first'
alias lla='lsd -lAhS --blocks permission,group,size,date,name  --date relative --group-dirs first'
alias tree='lsd --tree --group-dirs first --ignore-glob node_modules'
#alias cat='chroma --style="monokai" --html-tab-width=4'
alias cat='pygmentize -O style=dracula,noitalic'
alias zshconfig="vim $HOME/.zshrc"
alias vimconfig="vim $HOME/.vimrc"
alias weather='curl wttr.in'

export GOROOT='/usr/local/go'
export GOPATH="$HOME/go"
export DENO_INSTALL="$HOME/.deno"
export JAVA_HOME='/usr/lib/jvm/jdk-15.0.2'

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$GOROOT/bin:$GOPATH/bin:$DENO_INSTALL/bin:$HOME/.cargo/bin:$JAVA_HOME/bin:~/.local/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.plugins/zdharma/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.plugins/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh
