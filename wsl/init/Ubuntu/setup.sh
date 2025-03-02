#!/bin/bash

# Install ansible
# sudo apt update && sudo apt install -y ansible

# docker setup
curl -fsSL https://get.docker.com -o get-docker.sh; sudo sh get-docker.sh; rm get-docker.sh;


# git setup using git credential manager

# Prompt user for GitHub username and email
read -p "Enter your GitHub username: " github_username
read -p "Enter your GitHub email: " github_email

git config --global user.name "$github_username"
git config --global user.email "$github_email"
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"