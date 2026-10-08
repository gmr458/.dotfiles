: "${ZPLUG_DIR:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh-plugins}"

plug() {
  local spec="$1" dir file

  if [[ -f "$spec" ]]; then
    file="$spec"
  elif [[ "$spec" = /* && -d "$spec" ]]; then
    dir="$spec"
  else
    dir="$ZPLUG_DIR/${spec:t}"
    if [[ ! -d "$dir" ]]; then
      print -P "%F{cyan}plug:%f installing $spec..."
      command git clone --depth 1 "${ZPLUG_GIT_PREFIX:-https://github.com/}${spec}.git" "$dir" \
        || { print -P "%F{red}plug:%f clone failed: $spec"; return 1 }
    fi
  fi

  if [[ -z "$file" ]]; then
    local -a inits=($dir/*.{plugin.,}{z,}sh{-theme,}(N))
    if (( ! $#inits )); then
      print -P "%F{red}plug:%f no init file in $dir"
      return 1
    fi
    file="$inits[1]"
  fi

  () { emulate -L zsh; source "$file"; }
}

plug_update() {
  for d in $ZPLUG_DIR/*(N/); do
    print -P "%F{cyan}plug:%f updating ${d:t}..."
    git -C "$d" pull --ff-only || true
  done
}
