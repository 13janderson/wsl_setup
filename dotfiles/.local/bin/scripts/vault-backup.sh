#!/bin/bash
# For proper use, add this to crontab with crontab -e
# Perform backup of entire vault, not just anything tracked by git
# * * * * * ~/.local/bin/scripts/vault-backup.sh
while [ true ]
do
    source ~/.local/bin/scripts/ghswitch.sh
    git_email=$(git config --local user.email)
    echo $git_email
  if [[ "$git_email" == "jackanderson02@outlook.com" ]]; then
      break
  fi
done
cd ~/vault/
git add .
timestamp=$(date)
git commit -am "wsl vault backup: ${timestamp}"
git push
cd -


