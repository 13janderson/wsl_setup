#!bin/zsh

fzf-history-widget() {
  me=$(basename "$0")
  selected=$(tac ~/.zsh_history | sed -E "/$me/d" | sed -E 's/(.*;)(.*)/\2/' | fzf)
  if [[ -n "$selected" ]]; then
    # Write the selected cmd to the current zshell
    print -z "$selected"
    zle accept-line # this doesn't do what the docs say it does, it's meant to execute the cmd 
  fi
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
