#!/bin/bash
# security_updates_audit.sh - Script to check for security updates

# Check for available security updates
echo "Checking for security updates:"
if ! command -v unattended-upgrade &> /dev/null; then
  sudo apt-get install unattended-upgrades -y
fi
unattended-upgrade --dry-run

# Ensure the server is configured to receive security updates
echo "Checking for automatic security updates configuration:"
if grep -q "APT::Periodic::Unattended-Upgrade" /etc/apt/apt.conf.d/20auto-upgrades; then
    echo "Automatic security updates are configured."
else
    echo "Automatic security updates are not configured."
fi

