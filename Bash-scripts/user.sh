#!/bin/bash

################################################################################
# Script Name:    user.sh
# Description:    Performs comprehensive audits on users and groups to identify
#                 potential security issues such as users with UID 0, users with
#                 empty or weak passwords, and provides a list of all users and
#                 groups on the system.
# Author:         Gayatri Pawar
# Date:           2024-08-25
# Version:        1.0
################################################################################

# Set the log file path where all output will be recorded
LOGFILE="/var/log/security_audit_and_hardening.log"

# Check if the log file exists; if not, create it
if [ ! -f "$LOGFILE" ]; then
    touch "$LOGFILE"
    echo "Created log file at $LOGFILE"
fi

# Function to log messages with timestamps
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

################################################################################
# User and Group Audits
################################################################################

# Start of user and group audit section
log_message "Starting user and group audits..."

# Listing all users on the system
log_message "Listing all users on the system:"
getent passwd | tee -a "$LOGFILE"

# Separator for readability in logs
log_message "------------------------------------------------------------"

# Listing all groups on the system
log_message "Listing all groups on the system:"
getent group | tee -a "$LOGFILE"

log_message "------------------------------------------------------------"

# Checking for users with UID 0 (should typically only be root)
log_message "Checking for users with UID 0 (superuser privileges):"
awk -F: '($3 == 0) {print}' /etc/passwd | tee -a "$LOGFILE"

log_message "------------------------------------------------------------"

# Checking for users with empty passwords (security risk)
log_message "Checking for users with empty passwords:"
awk -F: '($2 == "" ) {print}' /etc/shadow | tee -a "$LOGFILE"

log_message "------------------------------------------------------------"

# Checking for users with passwords less than 8 characters (weak passwords)
log_message "Checking for users with weak passwords (less than 8 characters):"
while IFS=':' read -r username password rest; do
    if [ -n "$password" ]; then
        password_length=${#password}
        if [ "$password_length" -lt 8 ]; then
            log_message "User $username has a weak password."
        fi
    fi
done < /etc/shadow

log_message "------------------------------------------------------------"

# End of user and group audit section
log_message "User and group audits completed successfully."

################################################################################
# Exit Script
################################################################################

exit 0
