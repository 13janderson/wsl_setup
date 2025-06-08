
#!/bin/bash
dfu () {
  cd ~/dev_setup/dotfiles
  symlink_dir=symlinks
  mkdir -p $symlink_dir
  git ls-files | while IFS= read -r df; do
    if [[ $df == *"$symlink_dir"* ]]; then
      echo "Skipping sylimk file for copy"
      continue
    fi

    # If file is a symlink, read the contents of the file to a local copy
    if [ -h $df ]; then
      symlimk_df="$symlink_dir/$df"
      echo "$symlink_dir"
      echo "$df"
      echo "$symlink_dir/$df"

      cp $(readlink $df) $symlink_df 
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
}

dfu
