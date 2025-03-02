#!/bin/bash

# docker setup

sudo groupadd docker
sudo usermod -aG docker $USER

# Install wslu - adds browser capability among other things (i guess)
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu

# git setup using gh cli
sudo apt update && sudo apt install gh -y
gh auth login
gh auth setup-git 


