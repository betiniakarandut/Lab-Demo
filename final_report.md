
# Final Year Project Report: Designing and Securing a Corporate Network

## Introduction

In this project, we were tasked with designing, implementing, and securing a scalable network architecture for a corporate environment. The project is divided into three main tasks:

- **Task A**: Configuring a DNS Server
- **Task B**: Designing a scalable and secure network architecture
- **Task C**: Enhancing network security through VPN setup, firewalls, and intrusion prevention

Each section covers the details of design, implementation, and the critical security measures applied throughout the network. The goal is to ensure secure communication, network segmentation, traffic control, and intrusion prevention.

---

## Task A: DNS Server Setup

### Objective:
To configure and install a DNS server that manages internal corporate domains and their IP address mappings, ensuring proper domain resolution.

### Steps:
1. **Update System**:
   We started by updating the Ubuntu system and installing Bind9 to manage the DNS service.
   
   ```bash
   sudo apt update && sudo apt install bind9 bind9utils bind9-doc -y
   ```

2. **Configuration**:
   Forward and reverse lookup zones were configured in `/etc/bind/named.conf.local`, which contained the necessary zone files to map domains and reverse IPs.

   - **Forward Zone**: Maps domain names to IP addresses.
   - **Reverse Zone**: Maps IP addresses to domain names.

3. **Testing**:
   The server was validated by using `named-checkzone` and `named-checkconf` commands to check the integrity of the DNS files. The setup was finalized by restarting the Bind9 service.

   ```bash
   sudo systemctl restart bind9
   ```

### Result:
The DNS server was successfully configured to handle corporate domain resolutions, allowing devices to communicate using internal domain names.

---

## Task B: Design and Secure Network Architecture

### Objective:
To design a scalable and secure network architecture for a corporate environment, ensuring network segmentation and secure communication across the network.

### Key Components:
1. **Network Segmentation**:
   - VLANs and subnets were implemented to segment different departments within the corporate network, providing isolation between servers, user devices, and guest networks.
   
2. **Critical Services**:
   - Configured DNS, DHCP, and VPN services to manage IP allocation and encrypted communication for remote access.
   
3. **Firewalls**:
   - Configured firewalls to filter traffic based on rules, allowing only necessary services and blocking unauthorized access.

4. **Monitoring**:
   - Industry-standard tools were integrated for monitoring network traffic, performance, and potential intrusions.

### Diagram:

The architecture diagram illustrated the separation of different network segments, the role of firewalls, VPN servers, and other security measures.

---

## Task C: Network Security Enhancements

### Objective:
To harden the network against external and internal threats by implementing VPNs, configuring additional security measures, and using tools like Fail2Ban and firewalls.

### 1. **VPN Setup**:
A VPN was implemented using `vpn_setup_guide.sh` to allow secure remote access for employees while preventing unauthorized access to corporate resources.

### 2. **Additional Security**:
In `additional_security.md`, we detailed various security policies and hardening practices, including patch management, user account management, and intrusion detection systems.

### 3. **Fail2Ban**:
`fail2ban_config.sh` was used to configure the Fail2Ban tool to monitor and block suspicious login attempts and brute-force attacks on sensitive services.

### 4. **Firewall Rules**:
`firewall_rules.sh` was used to establish detailed firewall rules that permit only necessary traffic while blocking harmful or unnecessary services. This involved the setup of iptables rules to control inbound and outbound traffic.

---

## Implementation Plan

A step-by-step outline for implementing the network design and security measures has been provided in `implementation_plan.md`. It defines roles, timelines, and key responsibilities for deploying this secure network environment in the corporate setting.

---

## Conclusion

This project aimed to design, implement, and secure a scalable network architecture for a corporate environment. By segmenting the network, configuring critical services, and applying robust security measures, we ensured a high level of security and reliability.

The network is now capable of handling both internal and external communication securely while being scalable for future expansion.

---

**Project Contributors**:  
[Betini Akarandut](https://github.com/betiniakarandut)
