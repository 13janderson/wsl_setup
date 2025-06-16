#!/bin/bash
gh auth switch > /dev/null 2>&1
email=$(gh api user/emails --jq '.[].email')
echo "gh: $email"
git config --global user.email $email
