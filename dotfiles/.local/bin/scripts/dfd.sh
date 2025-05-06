# Only want to copy files tracked by git
dfd ()
{
  cd ~/dev_setup/dotfiles
  git ls-files | while IFS= read -r df; do
    # Copy all files tracked by git
    cp "$df" "$HOME/$df"
  done
  cd - 
}

dfd > /dev/null 2>&1
 
# Reload shell
echo "dotfiles reloaded"
exec $SHELL
