#!/bin/bash

# Update package list and install necessary dependencies
echo "Updating package list and installing dependencies..."
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable Docker repository
echo "Setting up Docker repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again to include Docker packages
echo "Updating package list again to include Docker packages..."
sudo apt update -y

# Install Docker Engine
echo "Installing Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Enable and start Docker service
echo "Starting and enabling Docker service..."
sudo service docker start
sudo systemctl enable docker

# Allow running Docker commands without `sudo` by adding the user to the Docker group
echo "Adding the current user to the Docker group..."
sudo usermod -aG docker $USER

# Inform user that a restart is needed to apply the group changes
echo "Docker has been installed. You need to restart your WSL instance or run 'newgrp docker' to apply the group changes."

# Test Docker installation
echo "Testing Docker installation..."
docker --version


