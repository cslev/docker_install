#!/bin/bash
echo "Becoming root first..."
sudo echo "[OK]"

echo "Configuring docker repositories..."
# Add Docker's official GPG key:
sudo apt-get update 
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
echo "Getting OS name..."
os_release=$(grep '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"')

sudo curl -fsSL https://download.docker.com/linux/${os_release}/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/${os_release} \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Installing docker and docker-compose"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin