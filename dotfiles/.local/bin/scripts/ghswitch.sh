#!/bin/bash
gh auth switch
email=$(gh api user/emails --jq '.[].email')
git config --global user.email $email
