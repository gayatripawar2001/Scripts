# 1. System Resource Monitoring Dashboard

## Overview

This Bash script provides a comprehensive dashboard for monitoring various system resources on your proxy server. The script is designed to present real-time insights and can be executed to display a full dashboard or specific sections based on your needs.

## Features

- **Top 10 Applications**: Displays the top 10 applications consuming the most CPU and memory.
- **Network Monitoring**: Includes concurrent connections, packet drops, and network traffic (MB in and out).
- **Disk Usage**: Shows disk space usage and highlights partitions using more than 80% of the space.
- **System Load**: Provides current load average and CPU usage breakdown.
- **Memory Usage**: Displays total, used, and free memory, as well as swap memory usage.
- **Process Monitoring**: Lists the number of active processes and top 5 processes by CPU usage.
- **Service Monitoring**: Monitors essential services like `sshd`, `nginx`, `apache2`, and `iptables`.

## Usage

### Full Dashboard

- To view the complete monitoring dashboard==>
  ./monitoring.sh

View Specific Sections
To view individual sections of the dashboard, use the corresponding command-line switches:

1. Top 10 Applications==>./monitoring.sh -applications

2. Disk Usage==>./monitoring.sh -disk

3. System Load==>./monitoring.sh -load

4. Memory Usage==>./monitoring.sh -memory

5. Process Monitoring==>./monitoring.sh -processes

6. Service Monitoring==>./monitoring.sh -services

## Excecution
--------------------
Clone the repository:
* git clone https://github.com/gayatripawar2001/Scripts.git
  
Navigate to the script directory:
* cd Scripts
  
Make the script executable:
* chmod +x monitoring.sh

# 2. Linux Security Audit and Server Hardening Script

## Overview

This repository contains a Bash script suite designed to automate the security audit and server hardening process on Linux servers. The scripts are modular and reusable, allowing for easy deployment across multiple servers to ensure they meet stringent security standards. The script suite includes checks for common security vulnerabilities, IPv4/IPv6 configurations, public vs. private IP identification, and implements hardening measures.

## Features

- **User and Group Audits**: List all users and groups, identify users with UID 0, report non-standard users, and check for weak passwords.
- **File and Directory Permissions**: Scan for world-writable files, check `.ssh` directory permissions, and report SUID/SGID files.
- **Service Audits**: List running services, identify unnecessary or unauthorized services, and ensure critical services are correctly configured.
- **Firewall and Network Security**: Verify firewall configuration, report open ports, and check for insecure network configurations.
- **IP and Network Configuration Checks**: Identify public vs. private IPs, ensure sensitive services are not exposed on public IPs.
- **Security Updates and Patching**: Check for available security updates and ensure regular installation of updates.
- **Log Monitoring**: Identify suspicious log entries that may indicate a security breach.
- **Server Hardening Steps**: Implement SSH key-based authentication, disable IPv6, secure the bootloader, configure the firewall, and set up automatic updates.
- **Custom Security Checks**: Easily extend the script with custom security checks based on specific organizational policies.
- **Reporting and Alerting**: Generate a summary report and optionally send alerts for critical vulnerabilities or misconfigurations.

## File Structure

- **`execution.sh`**: Main script that sequentially executes all the other scripts.
- **`custome-security-checks.sh`**: Handles custom security checks.
- **`file.sh`**: Audits file and directory permissions.
- **`firewall-sec.sh`**: Manages firewall and network security checks.
- **`ip-config.sh`**: Conducts IP and network configuration checks.
- **`log-checks.sh`**: Monitors logs for suspicious activities.
- **`reporting-alert.sh`**: Generates reports and handles alerting.
- **`server-hardening.sh`**: Implements server hardening measures.
- **`service-audits.sh`**: Performs service audits.
- **`update-patching.sh`**: Manages security updates and patching.
- **`user.sh`**: Audits users and groups.

## Installation

1. **Clone the Repository**

   git clone git clone https://github.com/gayatripawar2001/Scripts.git-->
   cd security-audit-hardening
   
2. **Set Execution Permissions**

   Ensure all scripts have execution permissions:
   chmod +x *.sh

3. **Configure Custom Checks
    Modify custome-security-checks.sh if you need to add custom security checks. This script is designed to be extended based on specific organizational policies

### Usage
* Run the Main Script

The main script execution.sh will sequentially run all the audit and hardening scripts.

sudo ./execution.sh
* Review the Output

The script generates a detailed report that highlights any issues found during the security audit and the hardening process. It logs all findings and actions taken in the specified log file.

* Configure Alerts: 

If you need email alerts or notifications for critical vulnerabilities or misconfigurations, configure the reporting-alert.sh script to handle these notifications.

### Customization
* Custom Security Checks: 
You can add your own security checks by editing the custome-security-checks.sh file. This allows you to tailor the script to your specific security requirements.
* Reporting and Alerting: 
The reporting-alert.sh script can be customized to send email alerts or notifications. You may need to configure mail settings or integrate with third-party alerting tools.
* Firewall Rules: 
Update the firewall-sec.sh script to reflect the specific firewall rules required for your environment. This includes configuring iptables or UFW as needed.

### Contributing
Contributions are welcome! If you have improvements, suggestions, or new features to add, please fork the repository, make your changes, and submit a pull request.
