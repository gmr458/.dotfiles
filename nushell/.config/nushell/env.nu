$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

let os_name = sys host | get name
if $os_name == 'Fedora Linux' {
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
        | append '/usr/local/zig'
}

$env.LS_COLORS = (vivid generate nord)

def get_git_info [] {
    let tag = gstat | get tag
    if ($tag | str length) > 0 and $tag !~ 'no_tag' {
        return $' ($tag)'
    }

    let branch = gstat | get branch 
    if ($branch | str length) > 0 and $branch !~ 'no_branch' {
        return $' ($branch)'
    }

    return ''
}

$env.PROMPT_COMMAND = {||
    let exit_code = if ($env.LAST_EXIT_CODE == 0) {
        $'(ansi '#76946A')0(ansi reset)'
    } else {
        $'(ansi '#ab4642')($env.LAST_EXIT_CODE)(ansi reset)'
    }

    let current_path = match (do --ignore-errors {
        $env.PWD | path relative-to $nu.home-path
    }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let cmd_durarion = if ($env.CMD_DURATION_MS | into int) > 0 {
        ' ' ++ ($'($env.CMD_DURATION_MS)ms' | into duration | into string)
    } else { '' }

    let git_info = get_git_info

    $'($exit_code) (ansi '#6A9FB5')($current_path)(ansi '#9ca0b0')($git_info)(ansi reset)(ansi '#585858')($cmd_durarion)(ansi reset)'
}

$env.PROMPT_INDICATOR = {|| $' (ansi yellow)%(ansi reset) '}

$env.PROMPT_COMMAND_RIGHT = ''

$env.config = {
    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: ' | '
            type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
            }
            style: {
                text: '#c8c8c8'
                selected_text: { fg: '#c8c8c8' bg: '#4C5B2B' }
                description_text: '#585858'
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: ' ? '
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: '#c8c8c8'
                selected_text: { fg: '#c8c8c8' bg: '#4C5B2B' }
                description_text: '#585858'
            }
        }
    ]
}
