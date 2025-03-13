$env.GOROOT = '/usr/local/go'
$env.GOPATH = ($env.HOME | path join go)
$env.DENO_INSTALL = ($env.HOME | path join .deno)
$env.BUN_INSTALL = ($env.HOME | path join .bun)
$env.EDITOR = 'nvim'

$env.PATH = (
    $env.PATH
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
)

def fmt_ms [ms: int] {
    if $ms > 0 {
        let formatted = (
            $'($ms)ms'
            | into duration
            | into string
        )
        $" ($formatted)"
    } else {
        ''
    }
}

$env.PROMPT_COMMAND = {||
    let exit_code = if ($env.LAST_EXIT_CODE == 0) {
        $"(ansi green)0(ansi reset)"
    } else {
        $"(ansi red)($env.LAST_EXIT_CODE)(ansi reset)"
    }

    let current_path = match (do --ignore-shell-errors {
        $env.PWD | path relative-to $nu.home-path 
    }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let cmd_durarion = fmt_ms ($env.CMD_DURATION_MS | into int)

    $"($exit_code) (ansi blue)($current_path)(ansi reset)(ansi dark_gray)($cmd_durarion)(ansi reset)"
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
