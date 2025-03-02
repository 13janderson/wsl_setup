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
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"


