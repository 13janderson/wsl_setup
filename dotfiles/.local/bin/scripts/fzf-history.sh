#!bin/zsh

fzf-history-widget() {
  me=$(basename "$0")
  selected=$(tac ~/.zsh_history | sed -E "/$me/d" | sed -E 's/(.*;)(.*)/\2/' | fzf)
  if [[ -n "$selected" ]]; then
    eval "$selected" & 
    print -s "$selected"
    fc -W
    zle accept-line
  fi
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
