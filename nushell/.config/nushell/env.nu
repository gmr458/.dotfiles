$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

$env.GOROOT = '/usr/local/go'
$env.GOPATH = $env.HOME | path join go
$env.DENO_INSTALL = $env.HOME | path join .deno
$env.BUN_INSTALL = $env.HOME | path join .bun
$env.ANDROID_HOME = $env.HOME | path join Android Sdk
$env.EDITOR = 'nvim'

$env.PATH = $env.PATH
    | split row (char esep)
    | append ($env.HOME | path join .local bin)
    | append ($env.HOME | path join .cargo bin)
    | append ($env.GOROOT | path join bin)
    | append ($env.GOPATH | path join bin)
    | append '/usr/local/flutter/bin'
    | append ($env.DENO_INSTALL | path join bin)
    | append ($env.BUN_INSTALL | path join bin)
    | append '/usr/local/odin'
    | append '/usr/local/c3'

def fmt_ms [ms: int] : [nothing -> string] {
    match ($ms > 0) {
        true => {
            let formatted = $'($ms)ms' 
                | into duration 
                | into string
            $" ($formatted)"
        }
        false => ''
    }
}

def get_git_info [] {
    let exit_code = do -i { git rev-parse --is-inside-work-tree | complete } | get exit_code
    if $exit_code == 0 {
        let branch = git branch --show-current
        if ($branch | str length) > 0 {
            return $" ($branch)"
        } 
        
        let tag = do -i { git describe --tags --exact-match | complete } 
            | get stdout
            | str trim
        if ($tag | str length) > 0 {
            return $" #($tag)"
        } 

        let commit = git rev-parse --short HEAD
        if ($commit | str length) > 0 {
            return $" @($commit)"
        } 
    }
    
    return ""
}

$env.PROMPT_COMMAND = {||
    let exit_code = if ($env.LAST_EXIT_CODE == 0) {
        $"(ansi green)0(ansi reset)"
    } else {
        $"(ansi red)($env.LAST_EXIT_CODE)(ansi reset)"
    }

    let current_path = match (do --ignore-errors {
        $env.PWD | path relative-to $nu.home-path 
    }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let cmd_durarion = fmt_ms ($env.CMD_DURATION_MS | into int)
    let git_info = get_git_info 

    $"($exit_code) (ansi blue)($current_path)(ansi purple)($git_info)(ansi reset)(ansi dark_gray)($cmd_durarion)(ansi reset)"
}

$env.PROMPT_INDICATOR = {|| $" (ansi yellow)$(ansi reset) "}

$env.PROMPT_COMMAND_RIGHT = ""


$env.config = {
    menus: [
        {
            name: help_menu
            only_buffer_difference: true
            marker: " ? "
            type: {
                layout: description
                columns: 4
                col_width: 20
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: completion_menu
            only_buffer_difference: false
            marker: " | "
            type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: " ? "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
    ]
}
