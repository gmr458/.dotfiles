let running_linux = sys host
    | get long_os_version
    | str contains 'Linux'

if $running_linux {
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
        | append '/opt/gradle/gradle-9.1.0/bin'
        | append ($env.ANDROID_HOME | path join emulator)
        | append ($env.ANDROID_HOME | path join platform-tools)
}

$env.LS_COLORS = (vivid generate nord)

$env.FZF_DEFAULT_OPTS = "--prompt='❯ ' --pointer='▌' --highlight-line --color='gutter:-1' --scrollbar='█' --info=hidden --layout=reverse --no-bold --bind 'tab:down,btab:up'"

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

def pick_session [] {
    let session_dir = $'($env.HOME)/Documents/kitty_sessions'
    mkdir $session_dir
    let sessions = (
        fd -e kitty-session . $session_dir
            | lines
            | path basename
            | str join "\n"
    )
    let chosen = $sessions | fzf --prompt='Pick a session: '
    if ($chosen | is-not-empty) {
        let full_path = ($session_dir | path join $chosen)
        kitty --detach --session $full_path
    }
}

def ls_symlinks [] {
    ls -la
        | where type == symlink
        | reject readonly mode num_links inode user group created accessed modified
}

def get_git_modifications [] {
    let output = git status --porcelain=v2 | lines

    let ordinary_changed_entries = $output
        | where ($it | str starts-with '1')
        | parse '1 {XY} {_} {_} {_} {_} {_} {_} {path}'
        | where (
            ($it.XY | str ends-with 'M') or
            ($it.XY | str ends-with 'T')
        )
        | get path

    let renamed_or_copied_entries = $output
        | where ($it | str starts-with '2')
        | parse '2 {XY} {_} {_} {_} {_} {_} {_} {_} {path}	{_}'
        | where (
            ($it.XY | str ends-with 'M') or
            ($it.XY | str ends-with 'T')
        )
        | get path

    let untracked_entries = $output
        | where ($it | str starts-with '?')
        | parse '? {path}'
        | get path

    $ordinary_changed_entries ++ $renamed_or_copied_entries ++ $untracked_entries
}

def prettier_format [indent_width: int, ...to: path] {
    (prettier
        --write
        --tab-width=$'($indent_width)'
        ...$to)
}

def prettier_format_git [indent_width: int] {
    let files = get_git_modifications
        | where (
            ($it | str ends-with ".js") or
            ($it | str ends-with ".jsx") or
            ($it | str ends-with ".ts") or
            ($it | str ends-with ".tsx") or
            ($it | str ends-with ".json") or
            ($it | str ends-with ".css") or
            ($it | str ends-with ".scss") or
            ($it | str ends-with ".html") or
            ($it | str ends-with ".md") or
            ($it | str ends-with ".yaml") or
            ($it | str ends-with ".yml") or
            ($it | str ends-with ".vue") or
            ($it | str ends-with ".svelte") or
            ($it | str ends-with ".astro") or
            ($it | str ends-with ".graphql") or
            ($it | str ends-with ".mjs") or
            ($it | str ends-with ".cjs") or
            ($it | str ends-with ".less") or
            ($it | str ends-with "/")
        )

    if ($files | is-not-empty) {
        prettier_format $indent_width ...$files
    }
}

def biome_format [indent_width: int, ...to: path] {
    (biome format
        --verbose
        --write
        --indent-width=$'($indent_width)'
        --indent-style=space
        ...$to)
}

def biome_format_git [indent_width: int] {
    let files = get_git_modifications
        | where (
            ($it | str ends-with ".js") or
            ($it | str ends-with ".jsx") or
            ($it | str ends-with ".ts") or
            ($it | str ends-with ".tsx") or
            ($it | str ends-with ".json") or
            ($it | str ends-with ".css") or
            ($it | str ends-with ".scss") or
            ($it | str ends-with ".html") or
            ($it | str ends-with ".md") or
            ($it | str ends-with ".yaml") or
            ($it | str ends-with ".yml") or
            ($it | str ends-with ".vue") or
            ($it | str ends-with ".svelte") or
            ($it | str ends-with ".astro") or
            ($it | str ends-with ".graphql") or
            ($it | str ends-with ".mjs") or
            ($it | str ends-with ".cjs") or
            ($it | str ends-with ".less") or
            ($it | str ends-with "/")
        )

    if ($files | is-not-empty) {
        biome_format $indent_width ...$files
    }
}

def list_all_files_sorted_by_size [] {
    ls -a **/*
        | where $it.type == 'file'
        | sort-by size --reverse
}

def backup_postgres_db [
    user: string,
    dbname: string,
    prefix: string,
    to: path
] {
  let timestamp = date now | format date '%Y_%m_%d_%H_%M_%S'

  (pg_dump -U $user
      -d $dbname
      -F c
      -f $'($to)/($prefix)_($timestamp).dump')

  (pg_dump -U $user
      -d $dbname
      -F t
      -f $'($to)/($prefix)_($timestamp).tar')

  (pg_dump -U $user
      -d $dbname
      -F p
      -f $'($to)/($prefix)_($timestamp).sql')
}

def search_history [] {
    let cmds = history
        | get command
        | uniq
        | str join "\n"
    let chosen = $cmds | fzf --prompt='Search history: '
    if ($chosen | is-not-empty) {
        $chosen | wl-copy
        echo $"Command '($chosen)' copied to clipboard"
    }
}

def search_files [] {
    let chosen = (fzf --prompt='Search files: ')
    if ($chosen | is-not-empty) {
        $chosen | wl-copy
        echo $"Path '($chosen)' copied to clipboard"
    }
}

def kitty_theme_light [] {
    kitten themes --cache-age=-1 cold_light
}

def kitty_theme_dark [] {
    kitten themes --cache-age=-1 cold_dark
}


$env.PROMPT_COMMAND = {||
    let exit_code = if ($env.LAST_EXIT_CODE == 0) {
        $'(ansi '#76946A')0(ansi reset)'
    } else {
        $'(ansi '#ab4642')($env.LAST_EXIT_CODE)(ansi reset)'
    }

    let current_path = last_dir

    let cmd_duration_ms_int = $env.CMD_DURATION_MS | into int
    let cmd_durarion = if $cmd_duration_ms_int == 823 {
        ''
    } else if $cmd_duration_ms_int > 0 {
        ' ' ++ ($'($env.CMD_DURATION_MS)ms' | into duration | into string)
    } else {
        ''
    }

    $'($exit_code) (ansi '#6A9FB5')($current_path)(ansi '#9ca0b0')(ansi reset)(ansi '#585858')($cmd_durarion)(ansi reset)'
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
