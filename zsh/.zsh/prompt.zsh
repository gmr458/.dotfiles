function fmt_duration() {
  local total_ms=$1
  local ms=$((total_ms % 1000))
  local total_seconds=$((total_ms / 1000))
  local seconds=$((total_seconds % 60))
  local total_minutes=$((total_seconds / 60))
  local minutes=$((total_minutes % 60))
  local hours=$((total_minutes / 60))

  local out=""
  [[ $hours -gt 0 ]] && out+="${hours}hr "
  [[ $minutes -gt 0 ]] && out+="${minutes}min "
  [[ $seconds -gt 0 ]] && out+="${seconds}sec "
  [[ $ms -gt 0 ]] && out+="${ms}ms "
  echo "${out% }"
}

function gitstatus_prompt_update() {
  emulate -L zsh
  typeset -g GITSTATUS_PROMPT=''
  typeset -gi GITSTATUS_PROMPT_LEN=0

  gitstatus_query 'MY' || return 1
  [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || return 0

  local clean='%2F' # green foreground
  local modified='%11F' # yellow foreground
  local untracked='%12F' # blue foreground
  local conflicted='%9F' # red foreground

  local p

  local where # branch name, tag or commit
  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    where=$VCS_STATUS_LOCAL_BRANCH
  elif [[ -n $VCS_STATUS_TAG ]]; then
    p+='%f#'
    where=$VCS_STATUS_TAG
  else
    p+='%f@'
    where=${VCS_STATUS_COMMIT[1,8]}
  fi

  (( $#where > 32 )) && where[13,-13]="…" # truncate long branch names and tags
  p+="${clean}${where//\%/%%}" # escape %

  (( VCS_STATUS_COMMITS_BEHIND )) && p+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_COMMITS_AHEAD )) && p+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_PUSH_COMMITS_AHEAD )) && p+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  (( VCS_STATUS_STASHES )) && p+=" ${clean}*${VCS_STATUS_STASHES}"
  [[ -n $VCS_STATUS_ACTION ]] && p+=" ${conflicted}${VCS_STATUS_ACTION}"
  (( VCS_STATUS_NUM_CONFLICTED )) && p+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
  (( VCS_STATUS_NUM_STAGED )) && p+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
  (( VCS_STATUS_NUM_UNSTAGED )) && p+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
  (( VCS_STATUS_NUM_UNTRACKED )) && p+=" ${untracked}?${VCS_STATUS_NUM_UNTRACKED}"

  GITSTATUS_PROMPT="%F{8}on%f ${p}%f"

  GITSTATUS_PROMPT_LEN="${(m)#${${GITSTATUS_PROMPT//\%\%/x}//\%(f|<->F)}}"
}

if (( $+functions[gitstatus_start] )); then
  gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd gitstatus_prompt_update
fi

# Always: needed for ${GITSTATUS_PROMPT:+...} expansion in PROMPT.
setopt no_prompt_bang prompt_percent prompt_subst

function preexec() {
  timer=$(($(date +%s%0N) / 1000000))
}

function precmd() {
  # Exit code first: green 0, red otherwise.
  PROMPT='%(?.%F{#76946A}%?%f.%F{#ab4642}%?%f) '
  # Basename only (~ at $HOME), like nushell's last_dir.
  PROMPT+='%F{#6A9FB5}%1~%f'
  (( $+functions[gitstatus_query] )) && PROMPT+='${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}'

  if [ $timer ]; then
    now=$(($(date +%s%0N) / 1000000))
    elapsed=$(($now - $timer))

    if [ $elapsed -ne 0 ]; then
      PROMPT+="%F{#585858} $(fmt_duration $elapsed)%f"
    fi

    unset timer
  fi

  PROMPT+=' %F{yellow}$%f '
}
