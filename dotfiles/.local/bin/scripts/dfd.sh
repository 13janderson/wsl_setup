#!/bin/bash

# We only want this under version control to push it up to github
# this is never something we will manually modify.
skip=(".zsh_history" ".gitconfig")

# Only want to copy files tracked by git
cd ~/dev_setup/dotfiles
symlink_dir=.symlinks

git ls-files | while IFS= read -r df; do
  if [[ ${skip[@]} =~ $df ]]; then
    # Skip certian files that we do not want to overwrite when copying down our changes
    continue
  fi


  if ! [[ -h $df ]] && ! [[ $(dirname $df) == $symlink_dir ]]; then
    mkdir -p $HOME/$(dirname $df)
    if [[ -d $df ]]; then
      cp -r "$df/." "$HOME/$df"
    else
      cp "$df" "$HOME/$df"
    fi
  fi



done
cd - 
 
# Reload shell
source ~/.zshrc

