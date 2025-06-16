#!/bin/bash
encrypt=(".zsh_history")

if [ ${#encrypt[@]} -gt 0 ]; then
  echo "Enter encryption password: "
  pass=$(read  -s)
fi



cd ~/dev_setup/dotfiles
symlink_dir=.symlinks
mkdir -p $symlink_dir
git ls-files | while IFS= read -r df; do
  if [[ $df == *"$symlink_dir"* ]]; then
    continue
  fi

  if [[ ${encrypt[@]} =~ $df ]]; then
    openssl aes-256-cbc -pbkdf2 -salt -a -e -in -passin $HOME/$df -out $df -pass pass:$pass
    continue
  fi

  # # If file is a symlink, read the contents of the file to a local copy
  # if [ -h $df ]; then
  #   cp $() $symlink_dir
  #   # Ensure this file is added to git
  #   git add $symlink_df > /dev/null 2>&1
  # else
  #   # Copy all files tracked by git from root directory
  #   cp "$HOME/$df" "$df"
  # fi
done
git commit -am "dotfile sync $(date)"
git push
cd - 
