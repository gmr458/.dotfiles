# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# zstyle ':vcs_info:*' actionformats ' %F{#F8974E}%f %F{#BC3FBC}%b|%a%f'
# zstyle ':vcs_info:*' formats ' %F{#F8974E}%f %F{#BC3FBC}%b%f'
# zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat ' %b%:%r'

# PROMPT='%F{#C09553}󰝰%f %F{blue}%~%f${vcs_info_msg_0_} %(?.%F{green}❯.%F{red}✗ %? ❯)%f '

PROMPT='%F{245}%~%f %(?.%F{green}❯.%F{red}%? ❯)%f '

# ------------------------------------------------------------

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# ------------------------------------------------------------

# Environment variables
export GOROOT='/usr/local/go'
export GOPATH="$HOME/go"
export DENO_INSTALL="$HOME/.deno"
export PNPM_HOME="$HOME/.local/share/pnpm"
export JAVA_HOME='/usr/lib/jvm/java-17-openjdk'
# export BUN_INSTALL="$HOME/.bun"

export EDITOR=nvim

# ------------------------------------------------------------

# PATH
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$GOROOT/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH=$PATH:"$DENO_INSTALL/bin"
export PATH=$PATH:$PNPM_HOME
export PATH=$PATH:'/opt/apache-maven/apache-maven-3.8.7/bin'
export PATH=$PATH:'/opt/gradle/gradle-7.6/bin'
# export PATH=$PATH:'/usr/local/kotlinc/bin'
# export PATH=$PATH:"$HOME/.nimble/bin"
# export PATH=$PATH:"$(go env GOPATH)/bin"
# export PATH="$BUN_INSTALL/bin:$PATH"

# fpath=(~/.zsh/completion $fpath)

# ------------------------------------------------------------

nd () {
  mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# Alias
alias cls='clear'
alias md='mkdir'
alias ls='lsd'
alias lsa='lsd -A'
alias ll='lsd -l'
alias lla='lsd -lA'
alias tree='lsd --tree --ignore-glob node_modules --ignore-glob venv --ignore-glob target --ignore-glob bin --ignore-glob obj --ignore-glob __pycache__'
alias fzfp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {} --theme=Dracula' --preview-window=right:75%"

alias c_repos="cd ~/repos/internal/c"
alias csharp_repos="cd ~/repos/internal/csharp"
alias elixir_repos="cd ~/repos/internal/elixir"
alias go_repos="cd $GOPATH/src/github.com/gmr458"
alias java_repos="cd ~/repos/internal/java"
alias js_repos="cd ~/repos/internal/javascript"
alias lua_repos="cd ~/repos/internal/lua"
alias ocaml_repos="cd ~/repos/internal/ocaml"
alias py_repos="cd ~/repos/internal/python"
alias rust_repos="cd ~/repos/internal/rust"
alias ts_repos="cd ~/repos/internal/typescript"

# ------------------------------------------------------------

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# ------------------------------------------------------------

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# Disable case sensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ------------------------------------------------------------

# Node.js version manager
# eval "$(fnm env --use-on-cd)"

# Init Oh My Posh
# eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/config.jsonc)"

# source ~/.plugins/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# source ~/.plugins/zap-zsh/supercharge/supercharge.plugin.zsh
# source ~/.plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

# ------------------------------------------------------------

# open new foot terminal in the same directory
# function osc7-pwd() {
#     emulate -L zsh # also sets localoptions for us
#     setopt extendedglob
#     local LC_ALL=C
#     printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
# }

# function chpwd-osc7-pwd() {
#     (( ZSH_SUBSHELL )) || osc7-pwd
# }
# add-zsh-hook -Uz chpwd chpwd-osc7-pwd

# opam configuration
[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
