# Script to automate DNS Server setup

#!/bin/bash

# Step 1: Update system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install Bind9 DNS server
echo "Installing Bind9 and related packages..."
sudo apt install bind9 bind9utils bind9-doc -y

# Step 3: Configure Bind9
echo "Configuring Bind9 DNS server..."
sudo mkdir -p /etc/bind/zones
sudo tee /etc/bind/named.conf.local > /dev/null <<EOL
zone "example.com" {
    type master;
    file "/etc/bind/zones/db.example.com";
};
zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.168.1";
};
EOL

# Step 4: Create Forward Zone File
echo "Creating forward lookup zone file..."
sudo tee /etc/bind/zones/db.example.com > /dev/null <<EOL
; BIND data file for example.com
;
\$TTL    604800
@       IN      SOA     ns1.example.com. admin.example.com. (
                        3         ; Serial
                        604800    ; Refresh
                        86400     ; Retry
                        2419200   ; Expire
                        604800 )  ; Negative Cache TTL
;
@       IN      NS      ns1.example.com.
ns1     IN      A       192.168.1.10
www     IN      A       192.168.1.20
EOL

# Step 5: Create Reverse Zone File
echo "Creating reverse lookup zone file..."
sudo tee /etc/bind/zones/db.192.168.1 > /dev/null <<EOL
; BIND reverse data file for 192.168.1.0
;
\$TTL    604800
@       IN      SOA     ns1.example.com. admin.example.com. (
                        3         ; Serial
                        604800    ; Refresh
                        86400     ; Retry
                        2419200   ; Expire
                        604800 )  ; Negative Cache TTL
;
@       IN      NS      ns1.example.com.
10      IN      PTR     ns1.example.com.
20      IN      PTR     www.example.com.
EOL

# Step 6: Restart Bind9
echo "Restarting Bind9 service..."
sudo systemctl restart bind9

# Step 7: Confirm Bind9 status
sudo systemctl status bind9

# Step 8: Allow DNS traffic over UDP and TCP
echo "Allowing DNS traffic over UDP and TCP..."
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 53 -j ACCEPT

echo "DNS server setup complete!"
