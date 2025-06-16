#!/bin/bash
encrypt=(".zsh_history")

cd ~/dev_setup/dotfiles
symlink_dir=.symlinks
mkdir -p $symlink_dir
git ls-files | while IFS= read -r df; do
  if [[ $df == *"$symlink_dir"* ]]; then
    continue
  fi

  if [[ ${encrypt[@]} =~ $df ]]; then
    # TODO, read in password from system rather asking user for new password every time
    openssl aes-256-cbc -salt -a -e -in $HOME/$df -out $df
  fi

  # If file is a symlink, read the contents of the file to a local copy
  if [ -h $df ]; then
    cp $(readlink $df) $symlink_dir
    # Ensure this file is added to git
    git add $symlink_df > /dev/null 2>&1
  else
    # Copy all files tracked by git from root directory
    cp "$HOME/$df" "$df"
  fi
done
git commit -am "dotfile sync $(date)"
git push
cd - 
