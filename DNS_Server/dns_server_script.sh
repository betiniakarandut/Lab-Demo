#!/bin/bash

# Script to automate DNS Server setup

# Step 1: Update system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install Bind9 DNS server
echo "Installing Bind9 and related packages..."
sudo apt install bind9 bind9utils bind9-doc -y

# Check for proper installation
named -v
if [ $? -ne 0 ]; then
    echo "Bind9 installation failed!"
    exit 1
else
    echo "Bind9 is successfully installed."
fi

# Display Bind9 files
echo "Files present in Bind9 configuration directory:"
ls /etc/bind

# Display device details
echo "My device details:"
hostnamectl status

# Step 3: Configure hosts file
echo "Configuring /etc/hosts file..."
sudo tee /etc/hosts > /dev/null <<EOL
127.0.0.1       localhost
127.0.1.1       betini-HP-255-G7-Notebook-PC
192.168.0.188   betini.local
EOL

# Check hostname and fully qualified domain name (FQDN)
echo "Hostname:"
hostname
echo "Fully Qualified Domain Name (FQDN):"
hostname --fqdn

# Step 4: Configure Bind9 options
echo "Configuring Bind9 DNS server..."
sudo cp /etc/bind/named.conf.options /etc/bind/named.conf.options.orig
sudo tee /etc/bind/named.conf.options > /dev/null <<EOL
options {
    directory "/var/cache/bind";
    recursion yes;
    allow-query { any; };
    forwarders {
        8.8.8.8;
        8.8.4.4;
    };
    dnssec-validation auto;
    listen-on-v6 { any; };
};
EOL

# Backup and configure named.conf.local
echo "Configuring zones in Bind9..."
sudo cp /etc/bind/named.conf.local /etc/bind/named.conf.local.orig
sudo tee /etc/bind/named.conf.local > /dev/null <<EOL
zone "betini.local" {
    type master;
    file "/etc/bind/db.betini.local";
};
zone "0.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.0.168.192";
};
EOL

# Step 5: Create zone files
echo "Creating forward lookup zone file..."
sudo cp /etc/bind/db.local /etc/bind/db.betini.local
sudo tee /etc/bind/db.betini.local > /dev/null <<EOL
;
; BIND data file for betini.local
;
\$TTL    604800
@       IN      SOA     ns1.betini.local. admin.betini.local. (
                        3         ; Serial
                        604800    ; Refresh
                        86400     ; Retry
                        2419200   ; Expire
                        604800 )  ; Negative Cache TTL
;
@       IN      NS      ns1.betini.local.
ns1     IN      A       192.168.0.188
www     IN      A       192.168.0.188
EOL

echo "Creating reverse lookup zone file..."
sudo cp /etc/bind/db.127 /etc/bind/db.0.168.192
sudo tee /etc/bind/db.0.168.192 > /dev/null <<EOL
;
; BIND reverse data file for 192.168.0.0
;
\$TTL    604800
@       IN      SOA     ns1.betini.local. admin.betini.local. (
                        3         ; Serial
                        604800    ; Refresh
                        86400     ; Retry
                        2419200   ; Expire
                        604800 )  ; Negative Cache TTL
;
@       IN      NS      ns1.betini.local.
188     IN      PTR     ns1.betini.local.
188     IN      PTR     www.betini.local.
EOL

# Step 6: Check configuration for errors
echo "Checking Bind9 configuration files..."
sudo named-checkconf
if [ $? -ne 0 ]; then
    echo "Bind9 configuration error!"
    exit 1
fi

echo "Checking forward zone..."
sudo named-checkzone betini.local /etc/bind/db.betini.local
if [ $? -ne 0 ]; then
    echo "Forward zone configuration error!"
    exit 1
fi

echo "Checking reverse zone..."
sudo named-checkzone 0.168.192.in-addr.arpa /etc/bind/db.0.168.192
if [ $? -ne 0 ]; then
    echo "Reverse zone configuration error!"
    exit 1
fi

# Step 7: Restart Bind9
echo "Restarting Bind9 service..."
sudo systemctl restart bind9

# Step 8: Confirm Bind9 status
echo "Checking Bind9 status..."
sudo systemctl status bind9

# Update iptables
echo "updating iptables"
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 53 -j ACCEPT

# Step 9: Update resolv.conf for DNS queries
echo "Configuring /etc/resolv.conf..."
sudo tee /etc/resolv.conf > /dev/null <<EOL
nameserver 192.168.0.188
EOL

# Step 10: Test DNS server with nslookup and ping
echo "Testing DNS resolution..."
nslookup www.betini.local
ping -c 4 www.betini.local

echo "DNS server setup complete!"
