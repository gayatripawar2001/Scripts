# System Resource Monitoring Dashboard

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
* cd repository-name
  
Make the script executable:
* chmod +x monitoring.sh

