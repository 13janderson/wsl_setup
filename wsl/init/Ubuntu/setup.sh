#!/bin/bash

# Install ansible
sudo apt update && sudo apt install -y ansible

# docker setup
curl -fsSL https://get.docker.com -o get-docker.sh; sudo sh get-docker.sh; rm get-docker.sh;
sudo newgrp docker

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
    echo "FAILED gh auth login"
    gh auth login 
done

echo "gh auth login success"


