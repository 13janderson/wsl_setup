#!/bin/bash
# Perform backup of entire vault, not just anything tracked by git
cd ~/vault/
git add .
timestamp=$(date)
git commit -am "wsl vault backup: ${timestamp}"
git push
cd -


