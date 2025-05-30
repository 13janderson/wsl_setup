#!bin/zsh

fzf-history-widget() {
  me=$(basename "$0")
  selected=$(tac ~/.zsh_history | sed -E "/$me/d" | sed -E 's/(.*;)(.*)/\2/' | fzf)
  if [[ -n "$selected" ]]; then
    # Send keys to current tmux window and hit enter, I love tmux
    tmux send-keys "$selected" C-m
  fi
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
