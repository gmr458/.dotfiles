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
alias neovide="neovide --fork"
