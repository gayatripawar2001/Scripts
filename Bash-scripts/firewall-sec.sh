#!/bin/bash

# firewall_network_audit.sh - Script to audit firewall and network security

# This script checks the status of the firewall, lists open ports and their associated services,
# and checks for potentially insecure network configurations such as IP forwarding.

# Verify that a firewall is active and configured
echo "Checking firewall status:"
# Check if UFW or iptables firewall is active and print the status
if systemctl is-active --quiet ufw || systemctl is-active --quiet iptables; then
    echo "Firewall is active."
else
    echo "Firewall is not active."
fi

# Report any open ports and their associated services
echo "Listing open ports and associated services:"
# Use netstat to list all open ports (-tuln: tcp/udp, listening, numeric output)
netstat -tuln

# Check for IP forwarding or insecure network configurations
echo "Checking for IP forwarding:"
# Check if IP forwarding is enabled in the system (which can be a security risk)
if [ "$(sysctl net.ipv4.ip_forward)" = "net.ipv4.ip_forward = 1" ]; then
    echo "IP forwarding is enabled."
else
    echo "IP forwarding is disabled."
fi
