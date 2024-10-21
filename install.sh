#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <WG_CONFIG_FILE> <STREAM_CONFIG_FILE> <NETDATA_CONFIG_FILE>"
  exit 1
fi

# Variables to replace
WG_CONFIG_FILE="$1"
STREAM_CONFIG_FILE="$2"
NETDATA_CONFIG_FILE="$3"

# Check if the provided files exist
if [ ! -f "$WG_CONFIG_FILE" ]; then
  echo "Error: WireGuard config file '$WG_CONFIG_FILE' does not exist."
  exit 1
fi

if [ ! -f "$STREAM_CONFIG_FILE" ]; then
  echo "Error: Stream config file '$STREAM_CONFIG_FILE' does not exist."
  exit 1
fi

if [ ! -f "$NETDATA_CONFIG_FILE" ]; then
  echo "Error: Netdata config file '$NETDATA_CONFIG_FILE' does not exist."
  exit 1
fi

# Install dependencies if they are missing
sudo apt-get update

# Install WireGuard
if ! command -v wg &> /dev/null; then
  echo "WireGuard not found. Installing..."
  sudo apt-get install -y wireguard
else
  echo "WireGuard is already installed."
fi

# Install Netdata
if ! command -v netdata &> /dev/null; then
  echo "Netdata not found. Installing..."
  curl -o netdata-kickstart.sh https://raw.githubusercontent.com/netdata/netdata/master/packaging/installer/kickstart.sh
  chmod +x netdata-kickstart.sh
  sudo ./netdata-kickstart.sh
else
  echo "Netdata is already installed."
fi

# Setup WireGuard
sudo cp "$WG_CONFIG_FILE" /etc/wireguard/wg0.conf
sudo chmod 600 /etc/wireguard/wg0.conf
sudo wg-quick up wg0

# Setup Netdata configuration
sudo cp "$NETDATA_CONFIG_FILE" /etc/netdata/netdata.conf
sudo cp "$STREAM_CONFIG_FILE" /etc/netdata/stream.conf
sudo systemctl restart netdata

echo "WireGuard and Netdata have been installed and configured."
