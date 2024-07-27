#!/bin/bash

# Function to log messages
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
}

log "Starting Samba setup script..."

# Check if the group exists
if getent group $SMB_GROUP > /dev/null 2>&1; then
    log "Group $SMB_GROUP already exists."
else
    log "Adding group: $SMB_GROUP"
    groupadd $SMB_GROUP || { log "Failed to add group $SMB_GROUP"; exit 1; }
fi

# Check if the shared directory exists
if [ -d "$SMB_DIR" ]; then
    log "Shared directory $SMB_DIR already exists."
else
    log "Creating shared directory: $SMB_DIR"
    mkdir -p $SMB_DIR || { log "Failed to create directory $SMB_DIR"; exit 1; }
    chmod 770 $SMB_DIR || { log "Failed to set permissions on $SMB_DIR"; exit 1; }
fi

# Check if the user exists
if id -u $SMB_USER > /dev/null 2>&1; then
    log "User $SMB_USER already exists."
else
    log "Adding user: $SMB_USER"
    useradd -m $SMB_USER || { log "Failed to add user $SMB_USER"; exit 1; }
    echo -e "$SMB_PASS\n$SMB_PASS" | smbpasswd -a -s $SMB_USER || { log "Failed to set Samba password for $SMB_USER"; exit 1; }
    usermod -aG $SMB_GROUP $SMB_USER || { log "Failed to add user $SMB_USER to group $SMB_GROUP"; exit 1; }
    chown -R $SMB_USER:$SMB_GROUP $SMB_DIR || { log "Failed to change ownership of $SMB_DIR"; exit 1; }
fi

# Verify Samba configuration
log "Verifying Samba configuration..."
testparm -s || { log "Samba configuration verification failed"; exit 1; }

# Check if the necessary directories exist
log "Checking necessary directories..."
[ -d /var/run/samba ] || { log "/var/run/samba directory does not exist"; exit 1; }
[ -d /var/lib/samba ] || { log "/var/lib/samba directory does not exist"; exit 1; }

# Ensure proper permissions for Samba directories
log "Setting permissions for Samba directories..."
chmod 755 /var/run/samba || { log "Failed to set permissions on /var/run/samba"; exit 1; }
chmod 755 /var/lib/samba || { log "Failed to set permissions on /var/lib/samba"; exit 1; }

log "Samba setup script completed."

# Check if smbd is running
log "Checking Samba service status..."
if pgrep smbd > /dev/null 2>&1; then
    log "Samba service is running."
else
    log "Samba service is not running."
    exit 1
fi

# The script ends here, and the CMD in the Dockerfile will take over to run smbd in the foreground