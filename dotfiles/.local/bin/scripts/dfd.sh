#!/bin/zsh
# Only want to copy files tracked by git
cd ~/dev_setup/dotfiles
git ls-files | while IFS= read -r df; do
# Copy all files tracked by git
# cp "$df" "$HOME/$df"
if [ -h $df ]; then
  echo "$df is a symlink"
fi
done
cd - 
 
# Reload shell
source ~/.zshrc
