# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.plugins/romkatv/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ------------------------------------------------------------

# source ~/.plugins/romkatv/gitstatus/gitstatus.prompt.zsh
# source ~/.plugins/gmr458/zshprompt/transient_prompt.zsh

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
export JAVA_HOME='/usr/lib/jvm/java-17-openjdk-17.0.6.0.10-1.fc37.x86_64'

# ------------------------------------------------------------

# PATH
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$GOROOT/bin"
export PATH=$PATH:"$GOPATH/bin"
export PATH=$PATH:"$DENO_INSTALL/bin"
export PATH=$PATH:$PNPM_HOME
export PATH=$PATH:'/opt/apache-maven/apache-maven-3.8.7/bin'
export PATH=$PATH:'/opt/gradle/gradle-7.6/bin'
export PATH=$PATH:'/usr/local/kotlinc/bin'
# export PATH=$PATH:"$(go env GOPATH)/bin"

fpath=(~/.zsh/completion $fpath)

# ------------------------------------------------------------

# Alias
alias cls='clear'
alias md='mkdir'
alias ls='lsd'
alias lsa='lsd -A'
alias ll='lsd -l'
alias lla='lsd -lA'
alias tree='lsd --tree --ignore-glob node_modules --ignore-glob venv --ignore-glob target --ignore-glob bin --ignore-glob obj --ignore-glob __pycache__'
alias fzfp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {} --theme=Dracula' --preview-window=right:75%"

alias go_repos="cd $GOPATH/src/github.com/gmr458"
alias java_repos="cd ~/repos/mine/java"
alias javascript_repos="cd ~/repos/mine/javascript"
alias kotlin_repos="cd ~/repos/mine/kotlin"
alias python_repos="cd ~/repos/mine/python"
alias rust_repos="cd ~/repos/mine/rust"
alias typescript_repos="cd ~/repos/mine/typescript"

alias start_mongo_server="docker run -d --rm -p 27017:27017 --name mongo-server -v /var/lib/data:/data/db mongo:6.0.3"

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

source ~/.plugins/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
