# Network Analysis Tools

## Introduction
Network analysis tools are essential for monitoring, troubleshooting, and analyzing network traffic and connections. In this document, we will cover four important tools: **Nmap**, **Netstat**, **Wireshark**, and **Tcpdump**.

## Nmap
Nmap (Network Mapper) is an open-source tool designed for network exploration and security auditing.
- **Features:**
  - Host discovery
  - Port scanning
  - Service version detection
  - OS detection
### Install Nmap
```bash
sudo apt install nmap -y
```
### Basic Usage
To scan a host for open ports, you can use the following command:
```bash
nmap <target_ip>
```

### Example
```bash
nmap 192.168.1.1
```

## Netstat
Netstat is a command-line utility that displays networking statistics and connections.
- **Features:**
  - Displays active connections
  - Shows listening ports
  - Provides routing tables
  - 
### Install Netstat
```bash
sudo apt install net-tools -y
```

### Basic Usage
To view current TCP connections:
```bash
netstat -tn
```

## Wireshark
Wireshark is a widely-used network protocol analyzer that allows users to capture and interactively browse traffic.
- **Features:**
  - Packet capturing
  - Live traffic analysis
  - Detailed packet inspection

### Install wireshark
```bash
sudo apt install wireshark -y
```

### Basic Usage
To start capturing packets:
1. Open Wireshark.
2. Select the network interface to capture on.
3. Click "Start".

### Example
Capture HTTP traffic by entering the filter:
```plaintext
http
```

## Tcpdump
Tcpdump is a powerful command-line packet analyzer. It allows users to display and analyze packets in a concise manner.
- **Features:**
  - Captures packets on a network interface
  - Can output to files for later analysis

### Install Tcpdump
```bash
sudo apt install tcpdump -y
```

### Basic Usage
To capture packets:
```bash
tcpdump -i <interface>
```

### Example
```bash
tcpdump -i eth0
```
