$env.config = {
    show_banner: false
    table: {
        mode: single
    }
    shell_integration: {
        osc2: false
        osc133: true
    }
}

alias cls = clear
# alias ls-builtin = ls

# def ls [
#     --all (-a),
#     --long (-l),
#     --short-names (-s),
#     --full-paths (-f),
#     --du (-d),
#     --directory (-D),
#     --mime-type (-m),
#     --threads (-t),
#     ...pattern: glob,
# ]: [ nothing -> string ] {
#     let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
#     try {
#         (ls-builtin
#             --all=$all
#             --long=$long
#             --short-names=$short_names
#             --full-paths=$full_paths
#             --du=$du
#             --directory=$directory
#             --mime-type=$mime_type
#             --threads=$threads
#             ...$pattern
#         ) | sort-by type name -i | grid -ic -s '  '
#     } catch {
#         (ls-builtin
#             --all=$all
#             --long=$long
#             --short-names=$short_names
#             --full-paths=$full_paths
#             --du=$du
#             --directory=$directory
#             --mime-type=$mime_type
#             --threads=$threads
#             ...$pattern
#         ) | sort-by type name -i
#     }
# }

# def lsa [] {
#     try {
#         ls-builtin -a | sort-by type name -i | grid -ic -s '  '
#     } catch {
#         ls-builtin -a | sort-by type name -i
#     }
# }
# def ll [--long (-l)] { ls-builtin --long=$long | sort-by type name -i }
# def lla [] { ls-builtin -a | sort-by type name -i }

def ll [
    --du (-d) # Display the apparent directory size ("disk usage") in place of the directory metadata size
] {
    ls --long --du=$du
        | reject target readonly mode num_links inode user group created
        | sort-by type name
        | each { |it|
            let max_length = 22
            if ($it.name | str length) > $max_length {
                let truncated_name = ($it.name | str substring 0..$max_length) + "..."
                $it | upsert name $truncated_name
            } else {
                $it
            }
        }
}

def lla [
    --du (-d) # Display the apparent directory size ("disk usage") in place of the directory metadata size
] {
    ls --all --long --du=$du
        | reject target readonly mode num_links inode user group created
        | sort-by type name
        | each { |it|
            let max_length = 22
            if ($it.name | str length) > $max_length {
                let truncated_name = ($it.name | str substring 0..$max_length) + "..."
                $it | upsert name $truncated_name
            } else {
                $it
            }
        }
}

alias android_repos = cd ($env.HOME | path join AndroidStudioProjects)
alias c_repos = cd ($env.HOME | path join Repos internal c)
alias csharp_repos = cd ($env.HOME | path join Repos internal csharp)
alias elixir_repos = cd ($env.HOME | path join Repos internal elixir)
alias external_repos = cd ($env.HOME | path join Repos external)
alias gleam_repos = cd ($env.HOME | path join Repos internal gleam)
alias go_repos = cd ($env.GOPATH | path join src github.com gmr458)
alias internal_repos = cd ($env.HOME | path join Repos internal)
alias java_repos = cd ($env.HOME | path join Repos internal java)
alias js_repos = cd ($env.HOME | path join Repos internal javascript)
alias kotlin_repos = cd ($env.HOME | path join Repos internal kotlin)
alias lua_repos = cd ($env.HOME | path join Repos internal lua)
alias ocaml_repos = cd ($env.HOME | path join Repos internal ocaml)
alias py_repos = cd ($env.HOME | path join Repos internal python)
alias rust_repos = cd ($env.HOME | path join Repos internal rust)
alias ts_repos = cd ($env.HOME | path join Repos internal typescript)
alias ts_repos = cd ($env.HOME | path join Repos internal typescript)

# alias snvim = $env.NVIM_APPNAME=simple nvim
# alias neovide = neovide --fork .

let scheme = {
  recognized_command: '#76946A'
  unrecognized_command: '#ab4642'
  subtle: '#585858'
}

$env.config.color_config = {
    separator: $scheme.subtle
    header: '#c8c8c8'
    row_index: $scheme.subtle
    cell-path: $scheme.subtle
    shape_list: $scheme.subtle
    shape_record: $scheme.subtle
    filesize: {||
        if $in == 0B {
            '#b9f6ca'
        } else if $in < 1kb {
            '#69f0ae'
        } else if $in < 1MB {
            '#00e676'
        } else if $in < 1GB {
            '#00c853'
        } else if $in < 5GB {
            '#ffeb3b'
        } else if $in < 10GB {
            '#ffa000'
        } else {
            '#f44336'
        }
    }
    duration: {||
        if $in < 10sec {
            '#b9f6ca'
        } else if $in < 60sec {
            '#69f0ae'
        } else if $in < 60min {
            '#00e676'
        } else if $in < 24hr {
            '#00c853'
        } else if $in < 1wk {
            '#4caf50'
        } else if $in < 4wk {
            '#388e3c'
        } else if $in < 52wk {
            '#2e7d32'
        } else {
            '#1b5e20'
        }
    }
    date: {|| (date now) - $in |
        if $in < 10sec {
            '#b9f6ca'
        } else if $in < 60sec {
            '#69f0ae'
        } else if $in < 60min {
            '#00e676'
        } else if $in < 24hr {
            '#00c853'
        } else if $in < 1wk {
            '#4caf50'
        } else if $in < 4wk {
            '#388e3c'
        } else if $in < 52wk {
            '#2e7d32'
        } else {
            '#1b5e20'
        }
    }
    datetime: {|| (date now) - $in |
        if $in < 10sec {
            '#b9f6ca'
        } else if $in < 60sec {
            '#69f0ae'
        } else if $in < 60min {
            '#00e676'
        } else if $in < 24hr {
            '#00c853'
        } else if $in < 1wk {
            '#4caf50'
        } else if $in < 4wk {
            '#388e3c'
        } else if $in < 52wk {
            '#2e7d32'
        } else {
            '#1b5e20'
        }
    }
    shape_external: $scheme.unrecognized_command
    shape_internalcall: $scheme.recognized_command
    shape_external_resolved: $scheme.recognized_command
    shape_block: $scheme.recognized_command
    block: $scheme.recognized_command
}

$env.config.highlight_resolved_externals = true

source ~/.cache/carapace/init.nu
