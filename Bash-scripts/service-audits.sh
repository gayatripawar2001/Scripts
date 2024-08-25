#!/bin/bash
# service_audit.sh - Script to audit running services

# List all running services
echo "Listing all running services:"
systemctl list-units --type=service

# Check for unnecessary or unauthorized services
echo "Checking for unnecessary or unauthorized services:"
# Define a list of unauthorized services (modify this as needed)
unauthorized_services=("apache2" "vsftpd" "telnet")
for service in "${unauthorized_services[@]}"; do
    if systemctl is-active --quiet $service; then
        echo "Unauthorized service running: $service"
    fi
done

# Ensure that critical services are running and properly configured
echo "Ensuring critical services are running:"
critical_services=("sshd" "iptables")
for service in "${critical_services[@]}"; do
    if ! systemctl is-active --quiet $service; then
        echo "Critical service not running: $service"
    fi
done

# Check for services listening on non-standard or insecure ports
echo "Checking for services listening on non-standard ports:"
netstat -tuln | grep -E ':22|:80|:443'
