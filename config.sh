#!/bin/bash

# config.sh - Configuration loader for the backup script
# Handles loading and setting default configuration values

# Default configuration values
set_default_config() {
    # Default directories
    DEFAULT_SOURCE_DIR="/home/user/Documents"
    DEFAULT_BACKUP_DIR="/home/user/Backups"
    
    # Backup settings
    COMPRESSION_LEVEL=6
    DATE_FORMAT="%Y-%m-%d_%H-%M-%S"
    
    # Retention settings
    ENABLE_CLEANUP=true
    KEEP_BACKUPS_COUNT=10
    KEEP_BACKUPS_DAYS=30
    
    # Logging settings
    ENABLE_LOGGING=true
    LOG_FILE="backup.log"
    
    # Display settings
    SHOW_PROGRESS=true
    VERBOSE=false
}

# Function to load configuration from file
load_config() {
    local config_file="$1"
    
    # Set defaults first
    set_default_config
    
    # Load from config file if it exists
    if [[ -f "$config_file" ]]; then
        log_message "INFO" "Loading configuration from: $config_file"
        source "$config_file"
        return 0
    else
        log_message "WARN" "Config file not found: $config_file, using defaults"
        return 1
    fi
}

# Function to validate configuration
validate_config() {
    # Validate compression level
    if [[ ! "$COMPRESSION_LEVEL" =~ ^[1-9]$ ]]; then
        log_message "WARN" "Invalid compression level: $COMPRESSION_LEVEL, using default: 6"
        COMPRESSION_LEVEL=6
    fi
    
    # Validate numeric values
    if [[ ! "$KEEP_BACKUPS_COUNT" =~ ^[0-9]+$ ]] || [[ "$KEEP_BACKUPS_COUNT" -le 0 ]]; then
        log_message "WARN" "Invalid KEEP_BACKUPS_COUNT: $KEEP_BACKUPS_COUNT, using default: 10"
        KEEP_BACKUPS_COUNT=10
    fi
    
    if [[ ! "$KEEP_BACKUPS_DAYS" =~ ^[0-9]+$ ]] || [[ "$KEEP_BACKUPS_DAYS" -le 0 ]]; then
        log_message "WARN" "Invalid KEEP_BACKUPS_DAYS: $KEEP_BACKUPS_DAYS, using default: 30"
        KEEP_BACKUPS_DAYS=30
    fi
    
    # Validate boolean values
    case "$ENABLE_CLEANUP" in
        true|false) ;;
        *) 
            log_message "WARN" "Invalid ENABLE_CLEANUP: $ENABLE_CLEANUP, using default: true"
            ENABLE_CLEANUP=true 
            ;;
    esac
    
    case "$ENABLE_LOGGING" in
        true|false) ;;
        *) 
            log_message "WARN" "Invalid ENABLE_LOGGING: $ENABLE_LOGGING, using default: true"
            ENABLE_LOGGING=true 
            ;;
    esac
    
    case "$SHOW_PROGRESS" in
        true|false) ;;
        *) 
            log_message "WARN" "Invalid SHOW_PROGRESS: $SHOW_PROGRESS, using default: true"
            SHOW_PROGRESS=true 
            ;;
    esac
    
    case "$VERBOSE" in
        true|false) ;;
        *) 
            log_message "WARN" "Invalid VERBOSE: $VERBOSE, using default: false"
            VERBOSE=false 
            ;;
    esac
}

# Function to display current configuration
show_config() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo "Current Configuration:"
        echo "  Source Directory: $DEFAULT_SOURCE_DIR"
        echo "  Backup Directory: $DEFAULT_BACKUP_DIR"
        echo "  Compression Level: $COMPRESSION_LEVEL"
        echo "  Date Format: $DATE_FORMAT"
        echo "  Enable Cleanup: $ENABLE_CLEANUP"
        echo "  Keep Backups Count: $KEEP_BACKUPS_COUNT"
        echo "  Keep Backups Days: $KEEP_BACKUPS_DAYS"
        echo "  Enable Logging: $ENABLE_LOGGING"
        echo "  Log File: $LOG_FILE"
        echo "  Show Progress: $SHOW_PROGRESS"
        echo "  Verbose: $VERBOSE"
        echo ""
    fi
}

# Function to create a sample configuration file
create_sample_config() {
    local config_file="$1"
    
    cat > "$config_file" << 'EOF'
# Simple Backup Script Configuration File
# This file contains default settings for the backup script

# Default directories
DEFAULT_SOURCE_DIR="/home/user/Documents"
DEFAULT_BACKUP_DIR="/home/user/Backups"

# Backup settings
COMPRESSION_LEVEL=6          # Compression level (1-9, where 9 is maximum compression)
DATE_FORMAT="%Y-%m-%d_%H-%M-%S"

# Retention settings
ENABLE_CLEANUP=true          # Enable automatic cleanup of old backups
KEEP_BACKUPS_COUNT=10        # Number of recent backups to keep
KEEP_BACKUPS_DAYS=30         # Delete backups older than this many days

# Logging settings
ENABLE_LOGGING=true          # Enable logging to backup.log
LOG_FILE="backup.log"        # Log file name

# Notification settings
SHOW_PROGRESS=true           # Show progress during backup creation
VERBOSE=false                # Enable verbose output
EOF
    
    log_message "INFO" "Created sample configuration file: $config_file"
}