#!/bin/bash

# Install ansible
# sudo apt update && sudo apt install -y ansible

# docker setup
curl -fsSL https://get.docker.com -o get-docker.sh; sudo sh get-docker.sh; rm get-docker.sh;

# Install gh cli
apt-get install gh
# Preferable to use SSH keys
gh auth login 
gh auth setup-git 
#git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"

# Instal zsh and pre-configure it with oh-my-zsh
apt-get install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install fzf. Default opts configured in dotfiles
apt-get install fzf -y
apt-get install bat -y
