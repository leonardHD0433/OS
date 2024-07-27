#!/bin/sh

# Add a new group
groupadd $SMB_GROUP
mkdir $SMB_DIR
chmod 770 $SMB_DIR

# Add a new user and assign it to the group
useradd -m $SMB_USER
echo -e "$SMB_PASS\n$SMB_PASS" | smbpasswd -a -s $SMB_USER
usermod -aG $SMB_GROUP $SMB_USER

chcon -R -t samba_share_t /home/shareRecord
semanage fcontext -a -t samba_share_t "/home/shareRecord(/.*)?"
restorecon -Rv /home/shareRecord
load_policy

# Restart the Samba service
service smb restart
service nmb restart

# Verify Samba configuration
testparm -s

echo smbpasswd -a $SMB_USER

# Start the Samba server
exec /usr/bin/samba.sh