# 🖥️ Task A: Build and Implement DNS Server in Linux Using UDP and TCP

This document will guide you through setting up a DNS server in Linux using both **UDP** and **TCP** protocols. The DNS server will be configured using **Bind9**, a widely-used DNS server software.

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Installation and Setup](#installation-and-setup)
   - Step 1: System Update
   - Step 2: Install Bind9 DNS Server
   - Step 3: Configure Forward Zone
   - Step 4: Configure Reverse DNS Lookup
   - Step 5: Update DNS Resolver
   - Step 6: Allow UDP and TCP for DNS Traffic
   - Step 7: Restart Bind9 and Check Status
   - Step 8: Test DNS Server
3. [DNS Configuration Files](#dns-configuration-files)
4. [Automation Script](#automation-script)
5. [Troubleshooting](#troubleshooting)
6. [Enabling Bind9 on Startup](#enabling-bind9-on-startup)

---

## Prerequisites

Ensure you have the following before beginning the installation:
- A Linux system (Ubuntu or Debian recommended)
- Basic understanding of DNS concepts and Linux command-line operations
- Internet connection for package installation

---

## Installation and Setup

### **Step 1: System Update**

Start by updating the system packages to ensure everything is up to date and compatible.

```bash
sudo apt update && sudo apt upgrade -y
```

### **Step 2: Install Bind9 DNS Server**
Next, install the Bind9 DNS server software.

```bash
sudo apt install bind9 bind9utils bind9-doc -y
```
### **Step 3: Configure Forward Zone**

- Open the named.conf.local file to define your forward zone.
```bash
sudo nano /etc/bind/named.conf.local
```
- Add the following zone configuration:
```bash
zone "example.com" {
    type master;
    file "/etc/bind/zones/db.example.com";
};
```

- Create a directory to hold the zone files:
```bash
sudo mkdir /etc/bind/zones
```

- Create the zone file for example.com:
```bash
sudo nano /etc/bind/zones/db.example.com
```

- Add these DNS records:
```bash
;
; BIND data file for example.com
;
$TTL    604800
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
```

### **Step 4: Configure Reverse DNS Lookup**
- Open the named.conf.local file again:
```bash
sudo nano /etc/bind/named.conf.local
```

- Add a reverse zone entry:
```bash
zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.168.1";
};
```
- Create the reverse zone file:
```bash
sudo nano /etc/bind/zones/db.192.168.1
```

- Add the reverse DNS entries:
```bash
;
; BIND reverse data file for 192.168.1.0
;
$TTL    604800
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
```

### **Step 5: Update DNS Resolver**
- Open the **resolv.conf** file:
```bash
sudo nano /etc/resolv.conf
```

- Add the local DNS server IP address:
```bash
nameserver 127.0.0.1
```

### **Step 6: Allow UDP and TCP for DNS Traffic**
Use **iptables** to allow DNS traffic over both **UDP** and **TCP**.
```bash
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 53 -j ACCEPT
```

### **Step 7: Restart Bind9 and Check Status**
- Restart the **Bind9** service for the changes to take effect.
```bash
sudo systemctl restart bind9
```

- To check if the service is running:
```bash
sudo systemctl status bind9
```

### **Step 8: Test DNS Server**
- To test DNS resolution, use the **dig** command:
```bash
dig @localhost example.com
```

- For reverse DNS lookup, run:
```bash
dig -x 192.168.1.10 @localhost
```