#!/bin/bash
# ip_network_config_audit.sh - Script to audit IP and network configuration

# Identify public vs. private IP addresses
echo "Checking IP addresses:"
ip_addresses=$(ip addr | grep 'inet ' | awk '{print $2}')

for ip in $ip_addresses; do
    if [[ $ip =~ ^10\. || $ip =~ ^172\.16\. || $ip =~ ^192\.168\. ]]; then
        echo "Private IP: $ip"
    else
        echo "Public IP: $ip"
    fi
done

# Ensure sensitive services are not exposed on public IPs
echo "Checking for sensitive services exposed on public IPs:"
ss -tuln | grep -E ':22|:80|:443'
