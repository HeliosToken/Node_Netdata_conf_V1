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
1. Running the Script
Ensure the script is executable:

```bash
chmod +x install.sh
```
Run the script by passing the three configuration files as arguments:

```bash
Copy code
./install.sh <WG_CONFIG_FILE> <STREAM_CONFIG_FILE> <NETDATA_CONFIG_FILE>
```
For example:

```bash
Copy code
./install.sh wg0.conf stream.conf netdata.conf
```
## Argument Explanation
`<WG_CONFIG_FILE>`: Path to the WireGuard configuration file (e.g., wg0.conf).
`<STREAM_CONFIG_FILE>`: Path to the Netdata stream configuration file (e.g., stream.conf).
`<NETDATA_CONFIG_FILE>`: Path to the Netdata configuration file (e.g., netdata.conf).
If any of these files are not provided or do not exist, the script will throw an error and exit.

## WireGuard Configuration and Safety
WireGuard is started without enabling the service on boot to avoid potential issues.

Why?
When WireGuard is enabled as a system service (`wg-quick@wg0.service`), it automatically starts at every boot. However, if the configuration file (`wg0.conf`) is incorrect or misconfigured, the machine could lose internet access after every reboot, requiring manual intervention to fix the issue.

Solution
This script uses the following command to start WireGuard without enabling it on boot:
```bash
Copy code
sudo wg-quick up wg0
```
This starts the WireGuard interface manually, but does not enable it to run automatically at boot. This means:

If the configuration is correct, WireGuard will function as expected.
If the configuration is incorrect and blocks internet access, a simple reboot will turn off the WireGuard interface, restoring your internet connection.
This approach allows you to safely test and troubleshoot your WireGuard setup without risking loss of connectivity.

# Manually Enabling WireGuard at Boot
Once you are confident the WireGuard configuration is correct, you can enable it to start automatically at boot:
```bash
Copy code
sudo systemctl enable wg-quick@wg0
```
If you need to disable WireGuard from starting at boot (e.g., after fixing a misconfiguration):
```bash
Copy code
sudo systemctl disable wg-quick@wg0
```
# Restarting WireGuard Service
If you need to manually restart the WireGuard service after updating the configuration:
```bash
Copy code
sudo wg-quick down wg0
sudo wg-quick up wg0
```
## Dependencies
This script installs the following software:

WireGuard: A fast, modern VPN tunnel.
Netdata: A powerful real-time monitoring tool.
If these are not already installed, the script will install them for you.

## Manual Installation
To manually install these dependencies, use the following commands:

# Installing WireGuard
```bash
Copy code
sudo apt-get update
sudo apt-get install -y wireguard
```
Installing Netdata
```bash
Copy code
curl -o netdata-kickstart.sh https://raw.githubusercontent.com/netdata/netdata/master/packaging/installer/kickstart.sh
chmod +x netdata-kickstart.sh
sudo ./netdata-kickstart.sh
```
Netdata Configuration
To configure Netdata, the script copies the provided netdata.conf and stream.conf to the appropriate directories and restarts the Netdata service:
```bash
Copy code
sudo systemctl restart netdata
```
This ensures that Netdata is configured to monitor the system and stream data based on the provided configuration files.

# Output
Once the script is successfully run:

WireGuard will be configured with the given wg0.conf file and started.
Netdata will be installed and configured with the provided configuration files (netdata.conf and stream.conf).
## Troubleshooting
File Not Found Error
Ensure that you pass the correct paths to the configuration files. The script will exit if it does not find the specified files.

## Permission Issues
Ensure you are running the script with sufficient permissions. You may need to prefix the script with sudo if necessary:
```bash
Copy code
sudo ./install.sh <WG_CONFIG_FILE> <STREAM_CONFIG_FILE> <NETDATA_CONFIG_FILE>
```
## License
This project is open-source. Feel free to modify it as per your needs.

