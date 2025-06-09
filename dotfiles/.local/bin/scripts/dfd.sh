#!/bin/zsh
# Only want to copy files tracked by git
cd ~/dev_setup/dotfiles
symlink_dir=.symlinks

git ls-files | while IFS= read -r df; do
# Copy all files tracked by git
# echo $(dirname $df) 
if ! [[ -h $df ]] && ! [[ $(dirname $df) == $symlink_dir ]]; then
  cp "$df" "$HOME/$df"
fi
done
cd - 
 
# Reload shell
source ~/.zshrc
