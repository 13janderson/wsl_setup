#!/bin/bash
selected=$(cat ~/.zsh_history | sed -E 's/(.*;)(.*)/\2/' | fzf)
echo "> $selected"
eval $selected


