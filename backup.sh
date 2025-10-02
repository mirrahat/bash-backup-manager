#!/bin/bash

# My Backup Brain!
# Author: Mir Hasibul Hasan Rahat
# This is where the real backup magic happens.
# All my clever backup tricks live here!

# My name maker - creates unique names for each backup
generate_backup_filename() {
    local current_datetime=$(date "+$DATE_FORMAT")
    echo "backup_${current_datetime}.tar.gz"
}

# Function to perform the actual backup
perform_backup() {
    local source_directory="$1"
    local backup_directory="$2"
    local backup_filename="$3"
    local full_backup_path="${backup_directory}/${backup_filename}"
    
    log_message "INFO" "Starting backup of '$source_directory' to '$full_backup_path'"
    
    # Check disk space if possible
    local estimated_size=$(estimate_backup_size "$source_directory")
    if [[ $estimated_size -gt 0 ]]; then
        check_disk_space "$backup_directory" "$estimated_size"
        if [[ $? -ne 0 ]]; then
            return 1
        fi
    fi
    
    # Show progress information
    if [[ "$SHOW_PROGRESS" == "true" ]]; then
        echo "Creating backup..."
        echo "Source: $source_directory"
        echo "Destination: $full_backup_path"
        echo "Compression level: $COMPRESSION_LEVEL"
        echo ""
    fi
    
    # Prepare tar command with compression level
    local tar_cmd="tar"
    local tar_options="-czf"
    
    # Add compression level if gzip supports it
    if tar --help 2>/dev/null | grep -q "gzip.*level" || gzip --help 2>/dev/null | grep -q "\-[1-9]"; then
        export GZIP="-$COMPRESSION_LEVEL"
    fi
    
    # Create the backup with progress indication
    if [[ "$SHOW_PROGRESS" == "true" ]] && tar --help 2>/dev/null | grep -q "checkpoint"; then
        # Use tar with checkpoint for progress
        tar -czf "$full_backup_path" -C "$source_directory" . \
            --checkpoint=1000 --checkpoint-action=dot 2>/dev/null
    else
        # Simple tar without progress
        tar -czf "$full_backup_path" -C "$source_directory" . 2>/dev/null
    fi
    
    local tar_exit_code=$?
    
    # Reset GZIP environment variable
    unset GZIP
    
    return $tar_exit_code
}

# Function to verify backup
verify_backup() {
    local backup_path="$1"
    
    if [[ ! -f "$backup_path" ]]; then
        log_message "ERROR" "Backup file not found: $backup_path"
        return 1
    fi
    
    # Quick verification - check if tar file is valid
    if command -v tar >/dev/null 2>&1; then
        tar -tzf "$backup_path" >/dev/null 2>&1
        if [[ $? -ne 0 ]]; then
            log_message "ERROR" "Backup file appears to be corrupted: $backup_path"
            return 1
        fi
    fi
    
    log_message "INFO" "Backup verification passed: $backup_path"
    return 0
}

# Function to run complete backup process
run_backup() {
    local source_directory="$1"
    local backup_directory="$2"
    
    # Validate directories
    validate_directories "$source_directory" "$backup_directory"
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    
    # Generate backup filename
    local backup_filename=$(generate_backup_filename)
    local full_backup_path="${backup_directory}/${backup_filename}"
    
    # Perform the backup
    perform_backup "$source_directory" "$backup_directory" "$backup_filename"
    local backup_result=$?
    
    # Check if backup was successful
    if [[ $backup_result -eq 0 ]] && verify_backup "$full_backup_path"; then
        local backup_size=$(get_file_size "$full_backup_path")
        log_message "INFO" "Backup completed successfully. Size: $backup_size"
        
        echo ""
        echo "✓ Backup completed successfully!"
        echo "  File: $backup_filename"
        echo "  Size: $backup_size"
        echo "  Location: $backup_directory"
        
        # Cleanup old backups
        cleanup_old_backups "$backup_directory"
        
        return 0
    else
        log_message "ERROR" "Backup failed for '$source_directory'"
        echo "✗ Backup failed!"
        
        # Remove failed backup file if it exists
        if [[ -f "$full_backup_path" ]]; then
            rm -f "$full_backup_path"
            log_message "INFO" "Removed failed backup file: $backup_filename"
        fi
        
        return 1
    fi
}

# Function to list existing backups
list_backups() {
    local backup_directory="$1"
    
    if [[ ! -d "$backup_directory" ]]; then
        echo "Backup directory does not exist: $backup_directory"
        return 1
    fi
    
    echo "Existing backups in $backup_directory:"
    echo "======================================="
    
    local backup_files=($(ls -t "$backup_directory"/backup_*.tar.gz 2>/dev/null))
    
    if [[ ${#backup_files[@]} -eq 0 ]]; then
        echo "No backup files found."
        return 0
    fi
    
    printf "%-30s %-10s %-20s\n" "Filename" "Size" "Date"
    printf "%-30s %-10s %-20s\n" "--------" "----" "----"
    
    for backup_file in "${backup_files[@]}"; do
        local filename=$(basename "$backup_file")
        local size=$(get_file_size "$backup_file")
        local date=$(stat -c %y "$backup_file" 2>/dev/null | cut -d' ' -f1,2 | cut -d'.' -f1)
        
        printf "%-30s %-10s %-20s\n" "$filename" "$size" "$date"
    done
    
    echo ""
    echo "Total backups: ${#backup_files[@]}"
}

# Function to restore from backup
restore_backup() {
    local backup_file="$1"
    local restore_directory="$2"
    
    if [[ ! -f "$backup_file" ]]; then
        log_message "ERROR" "Backup file not found: $backup_file"
        return 1
    fi
    
    if [[ ! -d "$restore_directory" ]]; then
        mkdir -p "$restore_directory" 2>/dev/null
        if [[ $? -ne 0 ]]; then
            log_message "ERROR" "Cannot create restore directory: $restore_directory"
            return 1
        fi
    fi
    
    log_message "INFO" "Starting restore from '$backup_file' to '$restore_directory'"
    
    # Extract the backup
    tar -xzf "$backup_file" -C "$restore_directory" 2>/dev/null
    local restore_result=$?
    
    if [[ $restore_result -eq 0 ]]; then
        log_message "INFO" "Restore completed successfully"
        echo "✓ Restore completed successfully!"
        echo "  From: $(basename "$backup_file")"
        echo "  To: $restore_directory"
        return 0
    else
        log_message "ERROR" "Restore failed from '$backup_file'"
        echo "✗ Restore failed!"
        return 1
    fi
}