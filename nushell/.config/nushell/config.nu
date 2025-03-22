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

source ~/.cache/carapace/init.nu
