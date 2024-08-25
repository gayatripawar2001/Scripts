#!/bin/bash
# file_permission_audit.sh - Script to audit file and directory permissions

# Scan for files and directories with world-writable permissions
echo "Scanning for world-writable files and directories:"
find / -type d -perm -0002 -ls 2>/dev/null
find / -type f -perm -0002 -ls 2>/dev/null

# Check for the presence of .ssh directories and ensure they have secure permissions
echo "Checking .ssh directory permissions:"
find /home -type d -name ".ssh" -exec ls -ld {} \;

# Report any files with SUID or SGID bits set
echo "Scanning for files with SUID/SGID bits set:"
find / -perm /6000 -type f -exec ls -ld {} \; 2>/dev/null
