#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Hardening SSH configuration:"
# Restart SSH service (Ensure the correct service name is used)
if systemctl restart sshd.service 2>/dev/null; then
    echo "SSH service restarted successfully."
elif systemctl restart ssh.service 2>/dev/null; then
    echo "SSH service restarted successfully."
else
    echo "SSH service not found."
fi

echo "Disabling IPv6:"
if ! grep -q "net.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf; then
    echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
fi

echo "Securing the GRUB bootloader:"
if command_exists grub-mkpasswd-pbkdf2; then
    grub-mkpasswd-pbkdf2
else
    echo "grub-mkpasswd-pbkdf2 command not found, installing grub-common..."
    sudo apt-get install -y grub-common
    if command_exists grub-mkpasswd-pbkdf2; then
        grub-mkpasswd-pbkdf2
    else
        echo "Failed to secure the GRUB bootloader."
    fi
fi

echo "Implementing firewall rules:"
# Temporarily bypass the SSH check
export UFW_FORCE_ROOT=1
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable
unset UFW_FORCE_ROOT

