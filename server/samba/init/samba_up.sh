#!/bin/bash

# Function to log messages
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
}

# Start the smbd service
log "Starting Samba service..."
smbd --foreground --no-process-group &
SMBD_PID=$!

# Wait for a few seconds to allow smbd to start
sleep 5

# Check if the necessary directories exist
log "Checking necessary directories..."
[ -d /var/run/samba ] || { log "/var/run/samba directory does not exist"; exit 1; }
[ -d /var/lib/samba ] || { log "/var/lib/samba directory does not exist"; exit 1; }

# Ensure proper permissions for Samba directories
log "Setting permissions for Samba directories..."
chmod 755 /var/run/samba || { log "Failed to set permissions on /var/run/samba"; exit 1; }
chmod 755 /var/lib/samba || { log "Failed to set permissions on /var/lib/samba"; exit 1; }

# Check if smbd is running
log "Checking Samba service status..."
if ps -p $SMBD_PID > /dev/null 2>&1; then
    log "Samba service is running."
else
    log "Samba service is not running. Checking logs for details..."
    tail -n 20 /var/log/samba/log.smbd
    exit 1
fi

log "Samba setup script completed."

# Keep the container running
tail -f /dev/null