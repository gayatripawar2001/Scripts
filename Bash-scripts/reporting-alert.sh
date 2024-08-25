#!/bin/bash
# reporting_alerting.sh - Script to generate audit report and send alerts

REPORT_FILE="/var/log/security_audit_report.txt"

echo "Generating security audit report:"
{
    echo "User and Group Audits"
    ./user_group_audit.sh
    echo ""

    echo "File and Directory Permissions"
    ./file_permission_audit.sh
    echo ""

    echo "Service Audits"
    ./service_audit.sh
    echo ""

    echo "Firewall and Network Security"
    ./firewall_network_audit.sh
    echo ""

    echo "IP and Network Configuration Checks"
    ./ip_network_config_audit.sh
    echo ""

    echo "Security Updates and Patching"
    ./security_updates_audit.sh
    echo ""

    echo "Log Monitoring"
    ./log_monitoring.sh
    echo ""

    echo "Server Hardening Steps"
    ./server_hardening.sh
    echo ""

    echo "Custom Security Checks"
    ./custom_security_checks.sh
    echo ""
} > "$REPORT_FILE"

echo "Security audit completed. Report saved to $REPORT_FILE."

# Optional: Send the report via email (configure as needed)
# mail -s "Security Audit Report" user@example.com < "$REPORT_FILE"
