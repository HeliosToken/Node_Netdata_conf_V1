# Node_Setup_V1
this repo contain all info about the setup script that node owners need to launch on their machine to show on netdata their node stats

# WireGuard and Netdata Installation Script

This script installs and configures **WireGuard** and **Netdata** on a Linux machine. It requires three configuration files:
1. WireGuard configuration file (`wg0.conf`)
2. Netdata configuration file (`netdata.conf`)
3. Netdata stream configuration file (`stream.conf`)

## Prerequisites

Before running this script, you will need the following:
1. A Linux machine with `apt` package manager (e.g., Ubuntu/Debian).
2. Three configuration files that will be sent via mail when connecting the node on the DApp:
    - A WireGuard configuration file (`wg0.conf`).
    - A Netdata configuration file (`netdata.conf`).
    - A Netdata stream configuration file (`stream.conf`).

## Usage

### 1. Running the Script
Ensure the script is executable:
```bash
chmod +x install.sh

