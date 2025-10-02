#!/bin/bash

# Enhanced Backup Script - Main Entry Point
# Creates a compressed backup of a specified directory with advanced features.
#
# @author BASHCAVE
# @version 2.0.0
# @license MIT

# Script directory for finding modules and config
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load modules
source "${SCRIPT_DIR}/config.sh"
source "${SCRIPT_DIR}/utils.sh"
source "${SCRIPT_DIR}/backup.sh"

# Initialize configuration
CONFIG_FILE="${SCRIPT_DIR}/config.conf"

# Parse command line arguments
parse_arguments() {
    local source_directory=""
    local backup_directory=""
    local custom_config=""
    local list_mode=false
    local restore_mode=false
    local restore_file=""
    local restore_target=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -q|--quiet)
                VERBOSE=false
                SHOW_PROGRESS=false
                shift
                ;;
            -c|--config)
                custom_config="$2"
                shift 2
                ;;
            --no-cleanup)
                ENABLE_CLEANUP=false
                shift
                ;;
            --no-log)
                ENABLE_LOGGING=false
                shift
                ;;
            -l|--list)
                list_mode=true
                shift
                ;;
            -r|--restore)
                restore_mode=true
                restore_file="$2"
                restore_target="$3"
                shift 3
                ;;
            --create-config)
                create_sample_config "${2:-config.conf}"
                exit 0
                ;;
            -*)
                echo "Unknown option: $1"
                show_help
                exit 1
                ;;
            *)
                if [[ -z "$source_directory" ]]; then
                    source_directory="$1"
                elif [[ -z "$backup_directory" ]]; then
                    backup_directory="$1"
                else
                    echo "Too many arguments"
                    show_help
                    exit 1
                fi
                shift
                ;;
        esac
    done

    # Store parsed values in global variables
    PARSED_SOURCE_DIR="$source_directory"
    PARSED_BACKUP_DIR="$backup_directory"
    PARSED_CUSTOM_CONFIG="$custom_config"
    PARSED_LIST_MODE="$list_mode"
    PARSED_RESTORE_MODE="$restore_mode"
    PARSED_RESTORE_FILE="$restore_file"
    PARSED_RESTORE_TARGET="$restore_target"
}

# Main function
main() {
    # Parse command line arguments
    parse_arguments "$@"

    # Load configuration
    local config_to_load="$CONFIG_FILE"
    if [[ -n "$PARSED_CUSTOM_CONFIG" ]]; then
        config_to_load="$PARSED_CUSTOM_CONFIG"
    fi
    
    load_config "$config_to_load"
    validate_config
    
    echo "Enhanced Backup Script v2.0.0"
    echo "================================="
    
    show_config
    
    # Handle special modes
    if [[ "$PARSED_LIST_MODE" == "true" ]]; then
        local list_dir="${PARSED_BACKUP_DIR:-$DEFAULT_BACKUP_DIR}"
        list_backups "$list_dir"
        exit 0
    fi
    
    if [[ "$PARSED_RESTORE_MODE" == "true" ]]; then
        if [[ -z "$PARSED_RESTORE_FILE" ]] || [[ -z "$PARSED_RESTORE_TARGET" ]]; then
            echo "Error: Restore mode requires both backup file and target directory"
            show_help
            exit 1
        fi
        restore_backup "$PARSED_RESTORE_FILE" "$PARSED_RESTORE_TARGET"
        exit $?
    fi

    # Get source directory
    local source_directory="$PARSED_SOURCE_DIR"
    if [[ -z "$source_directory" ]]; then
        echo "Source directory (default: $DEFAULT_SOURCE_DIR):"
        read -p "Enter path or press Enter for default: " source_directory
        if [[ -z "$source_directory" ]]; then
            source_directory="$DEFAULT_SOURCE_DIR"
        fi
    fi

    # Get backup directory
    local backup_directory="$PARSED_BACKUP_DIR"
    if [[ -z "$backup_directory" ]]; then
        echo "Backup directory (default: $DEFAULT_BACKUP_DIR):"
        read -p "Enter path or press Enter for default: " backup_directory
        if [[ -z "$backup_directory" ]]; then
            backup_directory="$DEFAULT_BACKUP_DIR"
        fi
    fi

    # Run the backup
    run_backup "$source_directory" "$backup_directory"
    exit $?
}

# Run main function with all arguments
main "$@"
