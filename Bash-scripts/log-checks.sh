#!/bin/bash
# log_monitoring.sh - Script to monitor logs for suspicious activity

# Check for suspicious SSH login attempts
echo "Checking for suspicious SSH login attempts:"
grep "Failed password" /var/log/auth.log | tail -n 10
