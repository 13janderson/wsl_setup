#!/bin/bash
me=$(basename "$0")
selected=$(tac ~/.zsh_history | sed -E "/$me/d" | sed -E 's/(: [0-9]*:0;)(.*)/\2/' | awk '!seen[$0]++' | fzf)
echo $selected | xclip -se clipboard

if [[ -n "$selected" ]]; then
  # Send keys to current tmux window and hit enter, I love tmux.
  # only do this if we are inside a tmux session
  if [ "$TMUX" ]; then
    tmux send-keys "$selected" C-m
  else
    eval $selected
  fi
fi

