#!/bin/bash

# docker setup

sudo groupadd docker
sudo usermod -aG docker $USER


# git setup

# Prompt for GitHub username
read -p "Enter your GitHub username: " github_username

# Prompt for GitHub email
read -p "Enter your GitHub email: " github_email

# Configure Git with the provided username and email
git config --global user.name "$github_username"
git config --global user.email "$github_email"

# Setup git credential manager
# https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git
# Refers to your windows git credential manager version
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"

