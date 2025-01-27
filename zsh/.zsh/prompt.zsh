function fmt_ms() {
    local total_ms=$1

    local ms=$((total_ms % 1000))
    local total_seconds=$((total_ms / 1000))
    local seconds=$((total_seconds % 60))
    local total_minutes=$((total_seconds / 60))
    local minutes=$((total_minutes % 60))
    local hours=$((total_minutes / 60))

    local formatted=""
    [[ $hours -gt 0 ]] && formatted+=" ${hours}hr"
    [[ $minutes -gt 0 ]] && formatted+=" ${minutes}min"
    [[ $seconds -gt 0 ]] && formatted+=" ${seconds}sec"

    echo "$formatted"
}

function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  PROMPT='%(?.%F{green}%?%f.%F{red}%?%f) '
  PROMPT+="${VIRTUAL_ENV_PROMPT:+$VIRTUAL_ENV_PROMPT}"
  # PROMPT+='%F{blue}%1~%f'
  PROMPT+='%F{blue}%(4~|.../%3~|%~)%f'

  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed="$(($now-$timer))"
    formatted=$(fmt_ms $elapsed)

    PROMPT+="%F{8}${formatted:+$formatted}%f"

    unset timer
  fi

  PROMPT+=' %F{yellow}$%f '
}
