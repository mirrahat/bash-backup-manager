#!/bin/bash

# utils.sh - Utility functions for the backup script
# Contains logging, cleanup, validation, and helper functions

# Function to log messages
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    if [[ "$ENABLE_LOGGING" == "true" ]]; then
        echo "[$timestamp] [$level] $message" >> "${SCRIPT_DIR}/${LOG_FILE}"
    fi
    
    if [[ "$VERBOSE" == "true" ]] || [[ "$level" == "INFO" ]] || [[ "$level" == "ERROR" ]]; then
        echo "[$level] $message"
    fi
}

# Function to show help
show_help() {
    echo "Enhanced Backup Script v2.0.0"
    echo "Usage: $0 [OPTIONS] [SOURCE_DIR] [BACKUP_DIR]"
    echo ""
    echo "Options:"
    echo "  -h, --help          Show this help message"
    echo "  -v, --verbose       Enable verbose output"
    echo "  -q, --quiet         Quiet mode (minimal output)"
    echo "  -c, --config FILE   Use custom config file"
    echo "  --no-cleanup        Disable automatic cleanup"
    echo "  --no-log           Disable logging"
    echo ""
    echo "Examples:"
    echo "  $0                           # Interactive mode"
    echo "  $0 /home/user/docs /backups  # Backup docs to /backups"
    echo "  $0 -v /home/user/docs        # Verbose backup to default location"
}

# Function to validate directories
validate_directories() {
    local source_dir="$1"
    local backup_dir="$2"
    
    # Validate source directory
    if [[ ! -d "$source_dir" ]]; then
        log_message "ERROR" "Source directory does not exist: $source_dir"
        return 1
    fi
    
    # Create backup directory if it doesn't exist
    if [[ ! -d "$backup_dir" ]]; then
        mkdir -p "$backup_dir" 2>/dev/null
        if [[ $? -ne 0 ]]; then
            log_message "ERROR" "Cannot create backup directory: $backup_dir"
            return 1
        fi
        log_message "INFO" "Created backup directory: $backup_dir"
    fi
    
    return 0
}

# Function to cleanup old backups
cleanup_old_backups() {
    local backup_dir="$1"
    
    if [[ "$ENABLE_CLEANUP" != "true" ]]; then
        return 0
    fi
    
    log_message "INFO" "Starting cleanup of old backups in $backup_dir"
    
    # Remove backups older than specified days
    if [[ -n "$KEEP_BACKUPS_DAYS" ]] && [[ "$KEEP_BACKUPS_DAYS" -gt 0 ]]; then
        local old_backups=($(find "$backup_dir" -name "backup_*.tar.gz" -type f -mtime +$KEEP_BACKUPS_DAYS 2>/dev/null))
        for backup_file in "${old_backups[@]}"; do
            rm -f "$backup_file"
            log_message "INFO" "Removed old backup (>$KEEP_BACKUPS_DAYS days): $(basename "$backup_file")"
        done
    fi
    
    # Keep only specified number of recent backups
    if [[ -n "$KEEP_BACKUPS_COUNT" ]] && [[ "$KEEP_BACKUPS_COUNT" -gt 0 ]]; then
        local backup_files=($(ls -t "$backup_dir"/backup_*.tar.gz 2>/dev/null))
        local total_backups=${#backup_files[@]}
        
        if [[ $total_backups -gt $KEEP_BACKUPS_COUNT ]]; then
            for ((i=KEEP_BACKUPS_COUNT; i<total_backups; i++)); do
                rm -f "${backup_files[$i]}"
                log_message "INFO" "Removed old backup (count limit): $(basename "${backup_files[$i]}")"
            done
        fi
    fi
}

# Function to format file size
format_size() {
    local size_bytes="$1"
    if command -v numfmt >/dev/null 2>&1; then
        numfmt --to=iec-i --suffix=B "$size_bytes"
    else
        # Fallback for systems without numfmt
        if [[ $size_bytes -gt 1073741824 ]]; then
            echo "$(( size_bytes / 1073741824 ))GB"
        elif [[ $size_bytes -gt 1048576 ]]; then
            echo "$(( size_bytes / 1048576 ))MB"
        elif [[ $size_bytes -gt 1024 ]]; then
            echo "$(( size_bytes / 1024 ))KB"
        else
            echo "${size_bytes}B"
        fi
    fi
}

# Function to get human-readable file size
get_file_size() {
    local file_path="$1"
    if [[ -f "$file_path" ]]; then
        if command -v du >/dev/null 2>&1; then
            du -h "$file_path" | cut -f1
        else
            local size_bytes=$(stat -c%s "$file_path" 2>/dev/null || stat -f%z "$file_path" 2>/dev/null)
            format_size "$size_bytes"
        fi
    else
        echo "0B"
    fi
}

# Function to check available disk space
check_disk_space() {
    local directory="$1"
    local required_space="$2"  # in bytes
    
    if command -v df >/dev/null 2>&1; then
        local available_space=$(df -B1 "$directory" | awk 'NR==2 {print $4}')
        if [[ $available_space -lt $required_space ]]; then
            log_message "ERROR" "Insufficient disk space. Required: $(format_size $required_space), Available: $(format_size $available_space)"
            return 1
        fi
    fi
    
    return 0
}

# Function to estimate backup size (rough estimation)
estimate_backup_size() {
    local source_dir="$1"
    
    if command -v du >/dev/null 2>&1; then
        local size_kb=$(du -sk "$source_dir" 2>/dev/null | cut -f1)
        # Estimate compressed size as 30% of original (rough estimation)
        echo $(( size_kb * 1024 * 30 / 100 ))
    else
        # Return 0 if we can't estimate
        echo 0
    fi
}

# Function to show progress during backup
show_progress() {
    local message="$1"
    if [[ "$SHOW_PROGRESS" == "true" ]]; then
        echo "$message"
    fi
}