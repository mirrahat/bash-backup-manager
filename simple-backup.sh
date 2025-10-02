#!/bin/bash

# Simple Backup Script
# Creates a compressed backup of a specified directory.
#
# @author BASHCAVE
# @version 1.0.0
# @license MIT

echo "Simple Backup Script"
read -p "Enter the source directory path: " source_directory
read -p "Enter the backup directory path: " backup_directory

# Current date and time for backup filename uniqueness
current_datetime=$(date '+%Y-%m-%d_%H-%M-%S')
backup_filename="backup_${current_datetime}.tar.gz"

# Create backup
tar -czf "${backup_directory}/${backup_filename}" -C "${source_directory}" .

echo "Backup of '${source_directory}' completed successfully."
echo "Backup file created: ${backup_directory}/${backup_filename}"
