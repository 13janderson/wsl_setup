# !/bin/zsh
me=$(basename "$0")

fullme=$(realpath $0)
echo "$me"
selected=$(tac ~/.zsh_history | sed -E "/$me/d" | sed -E 's/(.*;)(.*)/\2/' | fzf)

echo "> $selected"

# Add command to clipboard
echo "$selected" | xclip -se clip

# Run the command
error=$(eval "$selected" 2>&1 1>/dev/null)
if [[ "$error" != "" ]]; then
  echo "$selected failed"
fi

# Add the command as a history entry
sed -i "$ s/^\(.*;\)\(.*\)/\1$selected/" ~/.zsh_history

