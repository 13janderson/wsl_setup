#!/bin/bash
# For proper use, add this to crontab with crontab -e
# Perform backup of entire vault, not just anything tracked by git
# * * * * * ~/.local/bin/scripts/vault-backup.sh
cd ~/vault/
git add .
timestamp=$(date)
git commit -am "wsl vault backup: ${timestamp}"
git push
cd -

