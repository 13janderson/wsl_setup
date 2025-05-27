# !/bin/bash
me=$(basename "$0")
echo "$me"
selected=$(tac ~/.zsh_history | sed -E "/$me/d" | sed -E 's/(.*;)(.*)/\2/' | fzf)
echo "> $selected"
eval "$selected"

# Check if the selected command is empty
if [ -z "$selected" ]; then
  echo "No command selected, exiting."
  exit 1
fi

# Write the command to a temporary file, escaping special characters
temp_file="/tmp/run_command.sh"
echo "#!/bin/bash" > "$temp_file"
printf '%s\n' "$selected" >> "$temp_file"

# Make the temporary file executable
chmod +x "$temp_file"

# Source the temporary file to run the command in the current shell
source "$temp_file"

# Clean up
rm -f "$temp_file"
