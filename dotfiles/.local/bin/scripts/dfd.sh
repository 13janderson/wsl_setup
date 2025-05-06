# Only want to copy files tracked by git
# dfd ()
# {
cd ~/dev_setup/dotfiles
git ls-files | while IFS= read -r df; do
# Copy all files tracked by git
cp "$df" "$HOME/$df"
done
cd - 
# }

 
# Reload shell
echo "dotfiles reloaded"
exec $SHELL
# source ~/.zshrc
