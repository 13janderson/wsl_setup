#!/bin/bash

# docker setup

sudo groupadd docker
sudo usermod -aG docker $USER


# git setup using gh cli

sudo apt update && sudo apt install gh -y
gh auth login

