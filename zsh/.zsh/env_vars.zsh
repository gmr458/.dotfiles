if [[ ! -f /etc/NIXOS ]]; then
  export DENO_INSTALL="$HOME/.deno"
  export BUN_INSTALL="$HOME/.bun"
  export ANDROID_HOME="$HOME/Android/Sdk"
  export JAVA_HOME='/usr/lib/jvm/java-17-temurin-jdk'
  export EDITOR=nvim
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi

export FZF_DEFAULT_OPTS="--prompt='❯ ' --pointer='▌' --highlight-line --color='gutter:-1' --scrollbar='█' --info=hidden --layout=reverse --no-bold --bind 'tab:down,btab:up'"
