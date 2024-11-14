# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# --- My Config ------------------------------

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

# aliases
alias cls='clear'
alias md='mkdir'

alias ls='ls --group-directories-first --color=always'
alias lsa='ls --group-directories-first --color=always --all'
alias ll='ls --group-directories-first --color=always -hl'
alias lla='ls --group-directories-first --color=always -hl --all'

alias tree='tree --dirsfirst'

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

# plugins
source ~/.plugins/romkatv/gitstatus/gitstatus.prompt.sh

fmt_ms() {
    local total_ms=$1

    local ms=$((total_ms % 1000))
    local total_seconds=$((total_ms / 1000))
    local seconds=$((total_seconds % 60))
    local total_minutes=$((total_seconds / 60))
    local minutes=$((total_minutes % 60))
    local hours=$((total_minutes / 60))

    local formatted=""
    [ $hours -gt 0 ] && formatted+="${hours}h "
    [ $minutes -gt 0 ] && formatted+="${minutes}min "
    [ $seconds -gt 0 ] && formatted+="${seconds}s "

    echo "$formatted"
}

GREEN="\[\033[32m\]"
RED="\[\033[31m\]"
BLUE="\[\033[34m\]"
YELLOW="\[\033[33m\]"
GRAY="\[\033[90m\]"
ORANGE="\[\033[38;5;214m\]"
RESET="\[\033[00m\]"
PURPLE="\[\033[35m\]"
TEAL="\[\033[38;5;30m\]"

trap 'timer_start' DEBUG
timer_start() {
    timer=${timer:-$(($(date +%s%N)/1000000))}
}

PROMPT_COMMAND=set_prompt
set_prompt() {
    local last_status=$?
    local status_color
    [ $last_status -eq 0 ] && status_color=$GREEN || status_color=$RED

    if [ -n "$timer" ]; then
        local now=$(($(date +%s%N)/1000000))
        local elapsed=$((now - timer))
        unset timer
        local formatted=$(fmt_ms $elapsed)
        time_info="${GRAY}${formatted}${RESET}"
    else
        time_info=""
    fi

    local venv_info=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv_info="($(basename "$VIRTUAL_ENV")) "
    fi

    local git_info=""
    if gitstatus_query && [[ "$VCS_STATUS_RESULT" == ok-sync ]]; then
        if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
            git_info="(${PURPLE}${VCS_STATUS_LOCAL_BRANCH//\\/\\\\}${RESET}" # escape backslash
        else
            git_info="(${PURPLE}@${VCS_STATUS_COMMIT//\\/\\\\}${RESET}" # escape backslash
        fi

        # ⇣42 if behind the remote.
        (( VCS_STATUS_COMMITS_BEHIND )) && git_info+=" ${GREEN}⇣${VCS_STATUS_COMMITS_BEHIND}"
        
        # ⇡42 if ahead of the remote.
        (( VCS_STATUS_COMMITS_AHEAD )) && git_info+=" ${GREEN}⇡${VCS_STATUS_COMMITS_AHEAD}"
        
        # ⇠42 if behind the push remote.
        (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && git_info+=" ${GREEN}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
        
        # ⇢42 if ahead of the push remote.
        (( VCS_STATUS_PUSH_COMMITS_AHEAD )) && git_info+=" ${GREEN}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
        
        # *42 if have stashes.
        (( VCS_STATUS_STASHES )) && git_info+=" ${GREEN}*${VCS_STATUS_STASHES}"
        
        # 'merge' if the repo is in an unusual state.
        [[ -n "$VCS_STATUS_ACTION" ]] && git_info+=" ${RED}${VCS_STATUS_ACTION}"
        
        # ~42 if have merge conflicts.
        (( VCS_STATUS_NUM_CONFLICTED )) && git_info+=" ${RED}~${VCS_STATUS_NUM_CONFLICTED}"
        
        # +42 if have staged changes.
        (( VCS_STATUS_NUM_STAGED )) && git_info+=" ${YELLOW}+${VCS_STATUS_NUM_STAGED}"
        
        # !42 if have unstaged changes.
        (( VCS_STATUS_NUM_UNSTAGED )) && git_info+=" ${YELLOW}!${VCS_STATUS_NUM_UNSTAGED}"
        
        # ?42 if have untracked files.
        (( VCS_STATUS_NUM_UNTRACKED )) && git_info+=" ${TEAL}?${VCS_STATUS_NUM_UNTRACKED}"

        git_info+="${RESET}) "
    fi

    PS1="${status_color}${last_status}${RESET} ${venv_info}${BLUE}\w${RESET} ${time_info}${git_info}${YELLOW}\$${RESET} "
}

PS1="${GREEN}0${RESET} ${BLUE}\w${RESET} ${YELLOW}\$${RESET} "

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
