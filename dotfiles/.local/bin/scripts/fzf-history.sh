#!/bin/bash
selected=$(tac ~/.zsh_history| sed -E 's/(.*;)(.*)/\2/' | fzf)
echo "> $selected"
eval $selected
