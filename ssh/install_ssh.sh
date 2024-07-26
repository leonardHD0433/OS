#!/bin/bash

#cd working directory
cd /workspace

# Update the package list
dnf update -y

# Install the SSH server
dnf install openssh-server -y
systemctl start sshd
systemctl enable sshd
systemctl status sshd
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Configure the SSH server


sudo reboot





