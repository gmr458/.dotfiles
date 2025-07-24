# keybindings, this is necessary on fedora for some reason
if [[ -f /etc/fedora-release ]]; then
    bindkey  "^[[H"   beginning-of-line
    bindkey  "^[[F"   end-of-line
    bindkey  "^[[3~"  delete-char
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word
fi
