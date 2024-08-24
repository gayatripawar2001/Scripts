#!/bin/bash

# Function to display the entire dashboard in a framed box
display_frame() {
    local content="$1"
    local width=80
    local border_char="#"
    local empty_line=$(printf "%-${width}s" " " | tr " " " ")

    # Print top border
    echo "$empty_line" | sed "s/ /$border_char/g"

    # Print each line with borders
    while IFS= read -r line; do
        printf "%s%-*s%s\n" "$border_char " "$((width-2))" "$line" " $border_char"
    done <<< "$content"

    # Print bottom border
    echo "$empty_line" | sed "s/ /$border_char/g"
}

# Function to display headers with bold and centered text
display_header() {
    local header_text="$1"
    local width=80  # Set width to match the border width
    local color="\e[1;34m"  # Bold blue
    local reset="\e[0m"

    echo
    # Print top border with header
    printf "%*s\n" $(((${#header_text} + width) / 2)) "$header_text" | tr ' ' '='
    echo -e "${color}$(printf "%*s\n" $(((${#header_text} + width) / 2)) "$header_text")${reset}"
    printf "%*s\n" $(((${#header_text} + width) / 2)) "$header_text" | tr ' ' '='
    echo
}

# Function to create a box around the content
display_box() {
    local content="$1"
    local color="\e[1;32m"  # Bold green
    local reset="\e[0m"

    echo -e "${color}------------------------------------------${reset}"
    echo -e "$content"
    echo -e "${color}------------------------------------------${reset}"
}

# Function to check service status
check_services() {
    display_header 'Service Monitoring'
    services=("sshd" "nginx" "apache2" "iptables")
    for service in "${services[@]}"; do
        if systemctl is-active --quiet $service; then
            echo "$service: Running"
        else
            echo "$service: Not Running"
        fi
    done
    echo
}

# Functions for individual monitoring sections
monitor_top_apps() {
    display_header 'Top 10 Applications by CPU and Memory Usage'
    echo 'By CPU Usage:'
    ps aux --sort=-%cpu | awk '{printf "%-10s %-8s %-5s %-s\n", $1, $2, $3, $11}' | head -n 11
    echo
    echo 'By Memory Usage:'
    ps aux --sort=-%mem | awk '{printf "%-10s %-8s %-5s %-s\n", $1, $2, $4, $11}' | head -n 11
    echo
}

monitor_network() {
    display_header 'Network Monitoring'
    display_box "Number of Concurrent Connections: $(ss -tun | grep ESTAB | wc -l)"
    display_box "Packet Drops:"
    netstat -i | grep -v Iface | awk '{ if ($5 != 0) print $1 ": " $5 " packet(s) dropped"; else print $1 ": No packet drops"}'
    display_box "MB in and out:"
    sar -n DEV 1 1 | grep '^Average:' | awk '{print "Rx: "$5" MB, Tx: "$6" MB"}'
    echo
}

monitor_disk() {
    display_header 'Disk Usage'
    df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $5 " of " $1 " mounted on " $6 }'
    echo
    display_box "Partitions using more than 80%:"
    df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ if ($5+0 > 80) print $1 " is at " $5 }'
    echo
}

monitor_system_load() {
    display_header 'System Load'
    display_box "Current Load Average: $(uptime | awk '{print $10 $11 $12}')"
    display_box "CPU Usage Breakdown: $(mpstat | awk 'NR==4 {print "User: "$3"% System: "$5"% Idle: "$12"%"}')"
    echo
}

monitor_memory() {
    display_header 'Memory Usage'
    free -m | awk 'NR==2{printf "Total: %sMB, Used: %sMB, Free: %sMB\n", $2, $3, $4 }'
    echo
    display_box "Swap Memory Usage: $(free -m | awk 'NR==3{printf "Total: %sMB, Used: %sMB, Free: %sMB\n", $2, $3, $4 }')"
    echo
}

monitor_processes() {
    display_header 'Process Monitoring'
    display_box "Number of Active Processes: $(ps -e | wc -l)"
    echo 'Top 5 Processes by CPU Usage:'
    ps aux --sort=-%cpu | head -n 6 | awk '{printf "%-10s %-8s %-5s %-s\n", $1, $2, $3, $11}'
    echo
}

# Parse command-line arguments
case "$1" in
    -cpu)
        monitor_top_apps
        ;;
    -memory)
        monitor_memory
        ;;
    -network)
        monitor_network
        ;;
    -disk)
        monitor_disk
        ;;
    -load)
        monitor_system_load
        ;;
    -processes)
        monitor_processes
        ;;
    -services)
        check_services
        ;;
    *)
        headline="Monitoring System Resources"
        output=$(cat <<EOF
$(display_header "$headline")
$(monitor_top_apps)
$(monitor_network)
$(monitor_disk)
$(monitor_system_load)
$(monitor_memory)
$(monitor_processes)
$(check_services)
EOF
        )
        display_frame "$output"
        ;;
esac
