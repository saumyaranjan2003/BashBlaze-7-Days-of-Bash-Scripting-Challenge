#!/bin/bash

# Check if a directory path is provided as a command-line argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory_path="$1"

# Function to create a timestamp in the format: YYYY-MM-DD_HH-MM-SS
get_timestamp() {
    date +"%Y-%m-%d_%H-%M-%S"
}

# Function to create a backup of the specified directory
create_backup() {
    local backup_path="${directory_path}/backup_$(get_timestamp)"

    # Copy all the files from the specified directory to the backup folder
    cp -r "${directory_path}/"* "$backup_path"

    echo "Backup created: $backup_path"
}

# Function to perform rotation and keep only the last 3 backups
perform_rotation() {
    # Get a list of all backup folders in the specified directory, sorted by modification time (oldest first)
    local backups=($(find "${directory_path}" -maxdepth 1 -type d -name "backup_*" | sort))

    # Calculate the number of backups that need to be removed to retain only the last 3 backups
    local num_backups=${#backups[@]}
    local num_backups_to_remove=$((num_backups - 3))

    if [ $num_backups_to_remove -gt 0 ]; then
        # Remove the oldest backup folders to retain only the last 3 backups
        for ((i = 0; i < num_backups_to_remove; i++)); do
            rm -r "${backups[i]}"
            echo "Removed backup: ${backups[i]}"
        done
    fi
}

# Main script logic
create_backup
perform_rotation


