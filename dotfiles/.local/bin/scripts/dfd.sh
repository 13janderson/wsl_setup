#!/bin/zsh
# Only want to copy files tracked by git
cd ~/dev_setup/dotfiles
git ls-files | while IFS= read -r df; do
# Copy all files tracked by git
if ! [ -h $df ]; then
  cp "$df" "$HOME/$df"
else
fi
done
cd - 
 
# Reload shell
source ~/.zshrc
