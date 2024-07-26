#!/bin/bash

# Update the package list
dnf update

# Install the SSH serve
dnf install openssh-server -y

# Start the SSH service
systemctl start sshd

# Enable the SSH service to start on boot
systemctl enable sshd

# Print the status of the SSH service
systemctl status sshd

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak



