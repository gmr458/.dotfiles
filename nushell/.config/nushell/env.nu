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

# def is_int [] {
#     ($in | describe) == int
# }

# def get_git_info [] {
#     let output = gstat
#
#     let branch_tag = $output
#         | get tag branch
#         | where { |it| 'no_' not-in $it }
#         | str join ' '
#
#     let status = $output
#         | reject repo_name tag branch remote
#         | rename '+' '+~' '+-' '+->' '+t' '?' '~' '-' 't' '->' '!' 'c' '↑' '↓' 'stshs'
#         | transpose key value
#         | where { |it| $it.value > 0 }
#         | each {
#             |it| insert color {
#                 match $it.key {
#                     '+' | '+~' | '+->' | '+t' => '#76946A'
#                     '+-' | '-' | 'c' => '#ab4642'
#                     '!' => '#585858'
#                     _ => '#f7ca88'
#                 }
#             }
#         }
#         | each {|it| $'(ansi $it.color)($it.key)($it.value)(ansi reset)' }
#         | str join ' '
#
#     let remote = match ($output | get remote) {
#         '' | 'no_remote' => ''
#         _ => ''
#     }
#
#     let result = [$remote, $branch_tag, $status]
#         | str join ' '
#         | str trim
#
#     match $result {
#         '' => ''
#         _ => $' ($result)'
#     }
# }

def relative_path_to_home [] {
    match (do --ignore-errors {
        $env.PWD | path relative-to $nu.home-path
    }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
}

def rename_tab [name] {
    print -r $"\u{1b}]0;($name)\u{7}"
}

def last_dir [] {
    if $env.PWD == $env.HOME {
        '~'
    } else {
        $env.PWD | path split | last
    }
}

def restart_waybar [] {
    killall waybar
    hyprctl dispatch exec waybar
}

def secs_to [secs: float, to: string] {
    $secs
        | into string
        | append 'sec'
        | str join ''
        | into duration
        | format duration $to
}

def size_current_dir [] {
    ls --all --du
        | get size
        | math sum
}

$env.PROMPT_COMMAND = {||
    let exit_code = if ($env.LAST_EXIT_CODE == 0) {
        $'(ansi '#76946A')0(ansi reset)'
    } else {
        $'(ansi '#ab4642')($env.LAST_EXIT_CODE)(ansi reset)'
    }

    let current_path = last_dir

    let cmd_durarion = if ($env.CMD_DURATION_MS | into int) > 0 {
        ' ' ++ ($'($env.CMD_DURATION_MS)ms' | into duration | into string)
    } else { '' }

    let git_info = git_prompt

    $'($exit_code) (ansi '#6A9FB5')($current_path)(ansi '#9ca0b0')($git_info)(ansi reset)(ansi '#585858')($cmd_durarion)(ansi reset)'
}

$env.PROMPT_INDICATOR = {|| $' (ansi yellow)$(ansi reset) '}

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
