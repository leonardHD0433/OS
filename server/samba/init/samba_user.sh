#!/bin/sh

# Add a new group
groupadd $SMB_GROUP

# Create the shared directory and set permissions
mkdir -p $SMB_DIR
chmod 770 $SMB_DIR

# Add a new user and assign it to the group
useradd -m $SMB_USER
echo -e "$SMB_PASS\n$SMB_PASS" | smbpasswd -a -s $SMB_USER
usermod -aG $SMB_GROUP $SMB_USER

# Start the Samba service
smbd
nmbd

# Verify Samba configuration
testparm -s

# Start the Samba server
exec /usr/sbin/smbd -FS