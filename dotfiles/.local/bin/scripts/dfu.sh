#!/bin/bash
dfu () {
  cd ~/dev_setup/dotfiles
  git ls-files | while IFS= read -r df; do
    # Copy all files tracked by git from root directory
    cp "$HOME/$df" "$df"
  done
  git commit -am "dotfile sync $(date)"
  git push
  cd - 
}

dfu
