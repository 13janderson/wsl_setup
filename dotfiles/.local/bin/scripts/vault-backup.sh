#!/bin/bash
# For proper use, add this to crontab with crontab -e
# Perform backup of entire vault, not just anything tracked by git
# * * * * * ~/.local/bin/scripts/vault-backup.sh
cd ~/vault/
while [ true ]
do
    source ~/.local/bin/scripts/ghswitch.sh
    git_email=$(git config --local user.email)
    if [[ "$git_email" == "jackanderson02@outlook.com" ]]; then
        break
    fi
done
git add .
timestamp=$(date)
git commit -am "wsl vault backup: ${timestamp}"
git push
cd -


