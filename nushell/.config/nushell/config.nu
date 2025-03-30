$env.config = {
    show_banner: false,
    table: {
        mode: compact
    }
}

alias cls = clear
alias ls-builtin = ls

def ls [
    --all (-a),
    --long (-l),
    --short-names (-s),
    --full-paths (-f),
    --du (-d),
    --directory (-D),
    --mime-type (-m),
    --threads (-t),
    ...pattern: glob,
]: [ nothing -> string ] {
    let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
    try {
        (ls-builtin
            --all=$all
            --long=$long
            --short-names=$short_names
            --full-paths=$full_paths
            --du=$du
            --directory=$directory
            --mime-type=$mime_type
            --threads=$threads
            ...$pattern
        ) | sort-by type name -i | grid -ic -s '  '
    } catch {
        (ls-builtin
            --all=$all
            --long=$long
            --short-names=$short_names
            --full-paths=$full_paths
            --du=$du
            --directory=$directory
            --mime-type=$mime_type
            --threads=$threads
            ...$pattern
        ) | sort-by type name -i
    }
}

def lsa [] {
    try {
        ls-builtin -a | sort-by type name -i | grid -ic -s '  '
    } catch {
        ls-builtin -a | sort-by type name -i
    }
}
def ll [--long (-l)] { ls-builtin --long=$long | sort-by type name -i }
def lla [] { ls-builtin -a | sort-by type name -i }


alias android_repos = cd ($env.HOME | path join AndroidStudioProjects)
alias c_repos = cd ($env.HOME | path join repos internal c)
alias csharp_repos = cd ($env.HOME | path join repos internal csharp)
alias elixir_repos = cd ($env.HOME | path join repos internal elixir)
alias external_repos = cd ($env.HOME | path join repos external)
alias gleam_repos = cd ($env.HOME | path join repos internal gleam)
alias go_repos = cd ($env.GOPATH | path join src github.com gmr458)
alias internal_repos = cd ($env.HOME | path join repos internal)
alias java_repos = cd ($env.HOME | path join repos internal java)
alias js_repos = cd ($env.HOME | path join repos internal javascript)
alias kotlin_repos = cd ($env.HOME | path join repos internal kotlin)
alias lua_repos = cd ($env.HOME | path join repos internal lua)
alias ocaml_repos = cd ($env.HOME | path join repos internal ocaml)
alias py_repos = cd ($env.HOME | path join repos internal python)
alias rust_repos = cd ($env.HOME | path join repos internal rust)
alias ts_repos = cd ($env.HOME | path join repos internal typescript)
alias ts_repos = cd ($env.HOME | path join repos internal typescript)

# alias snvim = $env.NVIM_APPNAME=simple nvim
alias neovide = neovide --fork .

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
        if $in < 1kb {
            '#3db887'
        } else if $in < 10kb {
            '#67b85f'
        } else if $in < 100kb {
            '#b8a43e'
        } else if $in < 10mb {
            '#d68447'
        } else if $in < 100mb {
            '#c45e5e'
        } else if $in < 1gb {
            '#d14d4d'
        } else {
            '#b45b7a'
        }
    }
    duration: {||
        if $in < 1day {
            '#86e58b'
        } else if $in < 1wk {
            '#78d17b'
        } else if $in < 4wk {
            '#67b85f'
        } else if $in < 12wk {
            '#559c4d'
        } else if $in < 24wk {
            '#4a8a4a'
        } else if $in < 52wk {
            '#3c753c'
        } else {
            '#336633'
        }
    }
    date: {|| (date now) - $in |
        if $in < 1day {
            '#86e58b'
        } else if $in < 1wk {
            '#78d17b'
        } else if $in < 4wk {
            '#67b85f'
        } else if $in < 12wk {
            '#559c4d'
        } else if $in < 24wk {
            '#4a8a4a'
        } else if $in < 52wk {
            '#3c753c'
        } else {
            '#336633'
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
