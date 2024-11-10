# keybindings, this is necessary on fedora for some reason
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# environment variables
export GOROOT='/usr/local/go'
export GOPATH="$HOME/go"
export DENO_INSTALL="$HOME/.deno"
export BUN_INSTALL="$HOME/.bun"
export EDITOR=nvim

# PATH
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$GOROOT/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/flutter/bin"
export PATH=$PATH:"$DENO_INSTALL/bin"
export PATH=$PATH:"$BUN_INSTALL/bin"
export PATH=$PATH:"/usr/local/odin"
export PATH=$PATH:"/usr/local/c3"

# path for completions
fpath=(~/.zsh/completion $fpath)

# aliases
alias cls='clear'
alias md='mkdir'

alias ls='ls --group-directories-first --color=always'
alias lsa='ls --group-directories-first --color=always --all'
alias ll='ls --group-directories-first --color=always -hl'
alias lla='ls --group-directories-first --color=always -hl --all'

alias tree='tree --dirsfirst'

# alias ls='lsd'
# alias lsa='lsd -A'
# alias ll='lsd -l'
# alias lla='lsd -lA'
# alias tree='lsd --tree --ignore-glob node_modules --ignore-glob venv --ignore-glob target --ignore-glob bin --ignore-glob obj --ignore-glob __pycache__'

# alias ls='eza --group-directories-first --icons=always'
# alias lsa='eza --group-directories-first --all --icons=always'
# alias ll='eza --group-directories-first --long --icons=always --smart-group'
# alias lla='eza --group-directories-first --long -all --icons=always --smart-group'
# alias tree='eza --tree --icons ignore-glob node_modules venv target bin obj __pycache__'

alias fzf_prev="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {} --theme=Dracula' --preview-window=right:75%"

alias android_repos="cd ~/AndroidStudioProjects"
alias c_repos="cd ~/repos/internal/c"
alias csharp_repos="cd ~/repos/internal/csharp"
alias elixir_repos="cd ~/repos/internal/elixir"
alias external_repos="cd ~/repos/external"
alias gleam_repos="cd ~/repos/internal/gleam"
alias go_repos="cd $GOPATH/src/github.com/gmr458"
alias internal_repos="cd ~/repos/internal"
alias java_repos="cd ~/repos/internal/java"
alias js_repos="cd ~/repos/internal/javascript"
alias kotlin_repos="cd ~/repos/internal/kotlin"
alias lua_repos="cd ~/repos/internal/lua"
alias ocaml_repos="cd ~/repos/internal/ocaml"
alias py_repos="cd ~/repos/internal/python"
alias rust_repos="cd ~/repos/internal/rust"
alias ts_repos="cd ~/repos/internal/typescript"

alias snvim="NVIM_APPNAME=simple nvim"
alias neovide="neovide --fork ."

# zsh history file
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt menu_complete

# zsh completion
autoload -Uz compinit && compinit

# menu for completion
zstyle ':completion:*' menu select

# disable case sensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# enable colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# nodejs version manager
# eval "$(fnm env --use-on-cd)"

# plugins
source ~/.plugins/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.plugins/romkatv/gitstatus/gitstatus.prompt.zsh
# source ~/.plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

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

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# zsh prompts

# how it looks: ~/.config/nvim main !12 ?1 ❯
# source ~/.plugins/romkatv/gitstatus/gitstatus.prompt.zsh
# PROMPT='%F{245}%~%f${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} %(?.%F{green}❯.%F{red}%? ❯)%f '

function fmt_ms() {
    local total_ms=$1

    local ms=$((total_ms % 1000))
    local total_seconds=$((total_ms / 1000))
    local seconds=$((total_seconds % 60))
    local total_minutes=$((total_seconds / 60))
    local minutes=$((total_minutes % 60))
    local hours=$((total_minutes / 60))

    local formatted=""
    [[ $hours -gt 0 ]] && formatted+="${hours}h "
    [[ $minutes -gt 0 ]] && formatted+="${minutes}min "
    [[ $seconds -gt 0 ]] && formatted+="${seconds}s "
    # [[ $ms -gt 0 ]] && formatted+="${ms}ms "

    echo "$formatted"
}

function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed="$(($now-$timer))"
    formatted=$(fmt_ms $elapsed)

    # PROMPT="%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%~%f %F{8}${formatted:+$formatted}%f%F{yellow}$%f "
    # PROMPT="%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%1~%f %F{8}${formatted:+$formatted}%f%F{yellow}$%f "
    PROMPT='%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%1~%f${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} %F{8}${formatted:+$formatted}%f%F{yellow}$%f '

    unset timer
  else
    # PROMPT="%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%~%f %F{yellow}$%f "
    # PROMPT="%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%1~%f %F{yellow}$%f "
    PROMPT='%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%1~%f${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} %F{yellow}$%f '
  fi
}

# PROMPT="%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%~%f %F{yellow}$%f "
# PROMPT="%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%1~%f${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} %F{yellow}$%f "
PROMPT='%(?.%F{green}%?%f.%F{red}%?%f) ${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}%F{blue}%1~%f${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} %F{yellow}$%f '

# curl functions
function curl_get_json() {
    curl -s -X GET $1 | python -m json.tool | bat -l json
}

function curl_post_json() {
    curl -s -X POST -H 'Content-Type: application/json' -d $2 $1 | python -m json.tool | bat -l json
}

function curl_put_json() {
    curl -s -X PUT -H 'Content-Type: application/json' -d $2 $1 | python -m json.tool | bat -l json
}

function curl_delete_json() {
    curl -s -X DELETE $1 | python -m json.tool | bat -l json
}

# extract functions
function extract_gz() {
    gzip -d $1
}

function extract_bz2() {
    bunzip2 $1
}

function extract_xz() {
    unxz $1
}

function extract_tar() {
    tar -xf $1
}

function extract_tar_gz() {
    tar -xzf $1
}

function extract_tar_bz2() {
    tar -xjf $1
}

function extract_tar_xz() {
    tar -xf $1
}

# upgrade system if necessary
function upgrade() {
    sudo dnf check-update --refresh
    if [ $? -eq 100 ]; then
        sudo dnf upgrade -y
    fi
}

function stop_all_docker_containers() {
    docker ps -q | xargs docker stop
}

function delete_all_docker_containers() {
    docker ps -a --format "{{.ID}}" | xargs docker rm
}

function status_mysqld() {
    sudo systemctl status mysqld
}

function start_mysqld() {
    sudo systemctl start mysqld
}

function stop_mysqld() {
    sudo systemctl stop mysqld
}

function status_postgres() {
    sudo systemctl status postgresql
}

function start_postgres() {
    sudo systemctl start postgresql
}

function stop_postgres() {
    sudo systemctl stop postgresql
}

function status_docker() {
    sudo systemctl status docker
}

function start_docker() {
    sudo systemctl start docker
}

function stop_docker() {
    sudo systemctl stop docker.service docker.socket
}

function status_redis() {
    sudo systemctl status redis
}

function start_redis() {
    sudo systemctl start redis
}

function stop_redis() {
    sudo systemctl stop redis
}

function copy_current_path() {
    wl-copy $(pwd)
}

function copy_current_dirname() {
    local result=${PWD##*/}
    result=${result:-/}
    wl-copy $result
}

function get_list_heaviest_dirs() {
    du -sh */ | sort -hr
}

function get_list_heaviest_files() {
    du -ah . | sort -rh
}

# mkdir and cd
nd () {
  mkdir -p -- "$1" &&
    cd -P -- "$1"
}

function kitty_theme_light() {
    kitten themes --cache-age=-1 cold_light
}

function kitty_theme_dark() {
    kitten themes --cache-age=-1 cold_dark
}
