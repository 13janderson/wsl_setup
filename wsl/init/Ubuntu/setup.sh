#!/bin/bash

# docker setup

sudo groupadd docker
sudo usermod -aG docker $USER

# Install wslu - adds browser capability among other things (i guess)
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu

# git setup using gh cli

# Prompt user for GitHub username and email
read -p "Enter your GitHub username: " github_username
read -p "Enter your GitHub email: " github_email

git config --global user.name "$github_username"
git config --global user.email "$github_email"
sudo apt update && sudo apt install gh -y

# gh auth with gh cli
while ! gh auth login; do 
    echo "gh auth login timed out. Trying again"
done

echo "gh auth login success"


