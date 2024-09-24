#!/bin/bash

# Firewall Rules Setup: Configuring UFW for network security

echo "Setting up UFW firewall rules..."

# Allow SSH for remote administration
sudo ufw allow OpenSSH

# Allow VPN traffic through UDP port 1194
sudo ufw allow 1194/udp

# Allow DNS traffic
sudo ufw allow 53/tcp
sudo ufw allow 53/udp

# Allow HTTP and HTTPS for web services
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Deny all other incoming traffic by default
sudo ufw default deny incoming

# Allow all outgoing traffic
sudo ufw default allow outgoing

# Enable UFW
sudo ufw enable

echo "Firewall rules successfully configured."
