#!/bin/bash
me=$(basename "$0")
echo "$me"
selected=$(tac ~/.zsh_history | sed -E "/$me/d" | sed -E 's/(.*;)(.*)/\2/' | fzf)
echo "> $selected"
eval $selected
