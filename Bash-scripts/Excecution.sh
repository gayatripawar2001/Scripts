#!/bin/bash

# Main script to automate security audits and server hardening
# Calls separate scripts for each task

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or with sudo."
    exit 1
fi

echo "Starting server hardening and security audit..."

# Call each script in sequence
sudo ./user.sh
#sudo ./file.sh
sudo ./service-audits.sh
sudo ./firewall-sec.sh
sudo ./ip-config.sh
sudo ./upadte-patching.sh
sudo ./log-checks.sh
sudo ./server-hardening.sh
sudo ./custom-security-checks.sh
sudo ./reporting-alert.sh

echo "Server hardening and security audit completed."
