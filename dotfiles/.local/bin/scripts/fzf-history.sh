#!/bin/bash
me=$(basename "$0")


TMP_FLAG=$(mktemp)

selected=$(tac ~/.zsh_history | sed -E "/$me/d" | sed -E 's/(: [0-9]*:0;)(.*)/\2/' | awk '!seen[$0]++' | fzf --bind "ctrl-y:execute-silent(echo {} | xclip -selection clipboard; echo y > $TMP_FLAG)+accept")

if [[ -f "$TMP_FLAG" ]]; then
  yanked=$(<"$TMP_FLAG")  # more efficient than `cat`
  rm $TMP_FLAG > /dev/null 2>&1
  if [[ $yanked == "y" ]]; then
    echo "Copied to clipboard with ctrl-y. Halting script."
    exit 0
  fi
fi

rm $TMP_FLAG > /dev/null 2>&1

if [[ -n "$selected" ]]; then
  # Send keys to current tmux window and hit enter, I love tmux.
  # only do this if we are inside a tmux session
  if [ "$TMUX" ]; then
    tmux send-keys "$selected" C-m
  else
    eval $selected
  fi
fi

