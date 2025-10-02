#!/bin/bash

# My Trusty Toolkit!
# Author: Mir Hasibul Hasan Rahat
# This is where I keep all my handy helper functions.
# Think of it as my Swiss Army knife for backup tasks!

# My personal diary writer - keeps track of what I'm doing
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

# My helpful guide - shows people how to use me
show_help() {
    echo "Your Friendly Backup Buddy v2.0.0"
    echo "Author: Mir Hasibul Hasan Rahat"
    echo "Hi! I'm here to help you backup your files safely and easily."
    echo ""
    echo "How to use me:"
    echo "  $0                           # Just run me and I'll ask what you need!"
    echo "  $0 /your/files /backup/spot  # Tell me exactly what and where"
    echo "  $0 /your/files              # I'll use your default backup location"
    echo ""
    echo "Special powers I have:"
    echo "  -h, --help          Show this friendly help message"
    echo "  -v, --verbose       Make me extra chatty about what I'm doing"
    echo "  -q, --quiet         Make me work silently"
    echo "  -l, --list          Show you what backups you already have"
    echo "  -r, --restore       Bring back your files from a backup"
    echo "  -c, --config FILE   Use your own special settings file"
    echo "  --create-config     Make a new settings file template"
    echo "  --no-cleanup        Skip cleaning up old backups this time"
    echo "  --no-log           Don't write to my diary this time"
    echo ""
    echo "Need more help? Check the README.md file - it's full of examples!"
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