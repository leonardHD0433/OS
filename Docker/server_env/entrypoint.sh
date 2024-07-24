#!/bin/bash

# Define the repository directory
REPO_DIR="/workspace"

# Check if the repository directory exists and is a Git repository
if [ -d "$REPO_DIR/.git" ]; then
	echo "Repository found. Fetching updates..."
	cd "$REPO_DIR"
	
	# Fetch updates from the remote
	git pull origin main
    
else
	echo "Repository not found or not a Git repository."
	# Optionally, clone the repository if it doesn't exist
	# git clone https://github.com/your/repo.git $REPO_DIR
fi

# Execute the default command
exec "$@"