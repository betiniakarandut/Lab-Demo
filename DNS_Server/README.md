# 🌐 DNS Server Setup Project

This project demonstrates the process of building and implementing a **DNS server** using **UDP** and **TCP** protocols on a Linux-based system. The DNS server is configured using **Bind9**, a robust and widely-used DNS software, to resolve domain names to IP addresses and vice versa. This project is divided into three main tasks, and the current documentation focuses on **Task A: DNS Server Setup**.

## 📋 Project Overview

DNS (Domain Name System) is the backbone of the modern internet, responsible for translating human-readable domain names (e.g., `example.com`) into machine-readable IP addresses. This project showcases how to configure a DNS server from scratch, manage zone files, and ensure both forward and reverse lookups are properly set up.

### 📝 Task A: Build and Implement a DNS Server in Linux

- **Objective**: Set up a DNS server using **Bind9** on a Linux machine that supports both UDP and TCP protocols.
- **Key Features**:
  - Installation and configuration of Bind9
  - Forward DNS zone setup to resolve domain names to IP addresses
  - Reverse DNS lookup configuration to resolve IP addresses to domain names
  - Firewall configuration to allow DNS traffic over UDP and TCP
  - Automated scripts to set up the DNS server for convenience

---

## 🚀 Getting Started

Follow the detailed [Setup Instructions](setup_instruction.md) to get the DNS server up and running. The process is fully automated with a provided script, or you can follow the manual steps for better understanding.

### Prerequisites
- A Linux system (Ubuntu or Debian recommended)
- Internet access for downloading and installing necessary packages
- Basic knowledge of Linux command line and DNS concepts

### Steps to Set Up the DNS Server:
1. **Update System**: Ensure your system is up to date.
2. **Install Bind9**: Install the DNS server software.
3. **Configure Forward Zone**: Set up zone files for domain name resolution.
4. **Configure Reverse Lookup Zone**: Set up reverse lookup for IP address resolution.
5. **Allow DNS Traffic**: Configure firewall rules for UDP and TCP traffic.
6. **Test DNS Setup**: Use tools like `dig` to verify your DNS setup is working.

For a full breakdown, check the **setup_instruction.md** file in this repository.

---

## 📂 Project Structure

```bash
📂 dns-server-setup/
├── 📄 README.md # Project Overview (this file) 
├── 📄 setup_instruction.md # Detailed setup instructions
├── 📂 configs/ # Contains DNS configuration files 
│ 
├── named.conf.local # DNS zone configurations 
│ 
├── db.example.com # Forward DNS zone file 
│ 
└── db.192.168.1 # Reverse DNS zone file
|
└── 🖥️ dns_server_script.sh # Bash script to automate DNS server setup


```

---

## ⚙️ Automation Script

To simplify the setup process, a fully automated Bash script, `dns_server_script.sh`, is provided. The script:
- Installs and configures Bind9
- Sets up forward and reverse DNS zones
- Configures firewall rules
- Restarts the DNS service and verifies its status

Run the script with the following command:

```bash
chmod +x dns_server_script.sh
./dns_server_script.sh
```
## 📊 Testing and Validation
Once the server is set up, you can test the DNS server using the following commands:

- Forward Lookup: Resolve a domain name to an IP address

```bash
Copy code
dig @localhost example.com
Reverse Lookup: Resolve an IP address to a domain name
```

```bash
Copy code
dig -x 192.168.1.10 @localhost
```
Check the syslog or journalctl for troubleshooting if needed.

## 📖 Resources
- Bind9 Documentation
- Iptables Documentation
- Linux DNS Server Configuration Guide

## 💡 Future Enhancements
- Implement DNSSEC to add an extra layer of security.
- Set up caching DNS for faster resolution.
- Add a web-based interface to manage DNS records.

## 🤝 Contribution
Feel free to contribute to this project! You can submit issues or pull requests to improve the documentation, scripts, or configurations.

## 📜 License
This project is licensed under the **MIT** License.

