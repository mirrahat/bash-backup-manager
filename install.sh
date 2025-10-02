#!/bin/bash

# install.sh - Installation script for Enhanced Backup Script
# Sets up the backup script system with proper permissions and configuration

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="$HOME/.backup-script"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Pretty colored messages to make things friendly!
print_status() {
    echo -e "${GREEN}😊 Great news!${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️  Heads up:${NC} $1"
}

print_error() {
    echo -e "${RED}😱 Oops!${NC} $1"
}

print_header() {
    echo -e "${BLUE}🚀 $1${NC}"
}

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        return 0  # Running as root
    else
        return 1  # Not running as root
    fi
}

# Let me check if you have everything I need!
check_dependencies() {
    print_status "Let me check if you have all the tools I need..."
    
    local missing_deps=()
    
    # I need these friends to work properly
    for cmd in tar gzip find; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_error "I'm missing some friends I need to work: ${missing_deps[*]}"
        echo "Could you please install these tools and try again? They usually come with your system!"
        echo "On Ubuntu/Debian: sudo apt install tar gzip findutils"
        echo "On MacOS: These should already be installed!"
        exit 1
    fi
    
    print_status "Perfect! I have everything I need to work!"
}

# Function to install system-wide
install_system_wide() {
    print_header "Installing Enhanced Backup Script (System-wide)"
    
    if ! check_root; then
        print_error "System-wide installation requires root privileges."
        echo "Please run: sudo $0 --system"
        exit 1
    fi
    
    # Copy main script
    cp "$SCRIPT_DIR/simple-backup.sh" "$INSTALL_DIR/backup-script"
    chmod +x "$INSTALL_DIR/backup-script"
    
    # Copy modules
    mkdir -p "$INSTALL_DIR/backup-script-modules"
    cp "$SCRIPT_DIR/config.sh" "$INSTALL_DIR/backup-script-modules/"
    cp "$SCRIPT_DIR/utils.sh" "$INSTALL_DIR/backup-script-modules/"
    cp "$SCRIPT_DIR/backup.sh" "$INSTALL_DIR/backup-script-modules/"
    
    # Update script to use system module path
    sed -i "s|source \"\${SCRIPT_DIR}/|source \"$INSTALL_DIR/backup-script-modules/|g" "$INSTALL_DIR/backup-script"
    
    # Create default config in /etc
    mkdir -p "/etc/backup-script"
    if [[ ! -f "/etc/backup-script/config.conf" ]]; then
        cp "$SCRIPT_DIR/config.conf" "/etc/backup-script/config.conf"
        print_status "Created system config at /etc/backup-script/config.conf"
    fi
    
    # Update script to use system config path
    sed -i "s|CONFIG_FILE=\"\${SCRIPT_DIR}/config.conf\"|CONFIG_FILE=\"/etc/backup-script/config.conf\"|g" "$INSTALL_DIR/backup-script"
    
    print_status "System-wide installation completed."
    print_status "You can now run 'backup-script' from anywhere."
}

# Function to install for current user
install_user() {
    print_header "Installing Enhanced Backup Script (User-only)"
    
    # Create user config directory
    mkdir -p "$CONFIG_DIR"
    
    # Copy scripts
    cp "$SCRIPT_DIR/simple-backup.sh" "$CONFIG_DIR/"
    cp "$SCRIPT_DIR/config.sh" "$CONFIG_DIR/"
    cp "$SCRIPT_DIR/utils.sh" "$CONFIG_DIR/"
    cp "$SCRIPT_DIR/backup.sh" "$CONFIG_DIR/"
    
    # Copy config if it doesn't exist
    if [[ ! -f "$CONFIG_DIR/config.conf" ]]; then
        cp "$SCRIPT_DIR/config.conf" "$CONFIG_DIR/"
        print_status "Created user config at $CONFIG_DIR/config.conf"
    fi
    
    # Make main script executable
    chmod +x "$CONFIG_DIR/simple-backup.sh"
    
    # Create symlink in user's local bin
    mkdir -p "$HOME/.local/bin"
    ln -sf "$CONFIG_DIR/simple-backup.sh" "$HOME/.local/bin/backup-script"
    
    print_status "User installation completed."
    print_warning "Make sure $HOME/.local/bin is in your PATH."
    print_status "You can add this line to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
}

# Function to create desktop shortcut (Linux only)
create_desktop_shortcut() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        local desktop_dir="$HOME/Desktop"
        local applications_dir="$HOME/.local/share/applications"
        
        mkdir -p "$applications_dir"
        
        cat > "$applications_dir/backup-script.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Enhanced Backup Script
Comment=Create backups of directories with advanced features
Exec=gnome-terminal -- backup-script
Icon=applications-utilities
Terminal=true
Categories=System;Utility;
EOF
        
        chmod +x "$applications_dir/backup-script.desktop"
        
        if [[ -d "$desktop_dir" ]]; then
            cp "$applications_dir/backup-script.desktop" "$desktop_dir/"
            chmod +x "$desktop_dir/backup-script.desktop"
            print_status "Created desktop shortcut"
        fi
        
        print_status "Created application menu entry"
    fi
}

# Function to show usage
show_usage() {
    echo "Enhanced Backup Script Installer"
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --system     Install system-wide (requires sudo)"
    echo "  --user       Install for current user only (default)"
    echo "  --uninstall  Remove installation"
    echo "  --desktop    Create desktop shortcut (Linux only)"
    echo "  --help       Show this help message"
}

# Function to uninstall
uninstall() {
    print_header "Uninstalling Enhanced Backup Script"
    
    # Remove system-wide installation
    if check_root; then
        rm -f "$INSTALL_DIR/backup-script"
        rm -rf "$INSTALL_DIR/backup-script-modules"
        rm -rf "/etc/backup-script"
        print_status "Removed system-wide installation"
    fi
    
    # Remove user installation
    rm -f "$HOME/.local/bin/backup-script"
    if [[ -d "$CONFIG_DIR" ]]; then
        echo "Remove user configuration directory $CONFIG_DIR? (y/N)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            rm -rf "$CONFIG_DIR"
            print_status "Removed user configuration"
        fi
    fi
    
    # Remove desktop shortcut
    rm -f "$HOME/Desktop/backup-script.desktop"
    rm -f "$HOME/.local/share/applications/backup-script.desktop"
    
    print_status "Uninstallation completed"
}

# Main installation logic
main() {
    check_dependencies
    
    case "${1:-}" in
        --system)
            install_system_wide
            ;;
        --user|"")
            install_user
            ;;
        --desktop)
            create_desktop_shortcut
            ;;
        --uninstall)
            uninstall
            ;;
        --help|-h)
            show_usage
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
    
    print_header "Installation Summary"
    echo "Enhanced Backup Script has been installed successfully!"
    echo ""
    echo "Quick Start:"
    echo "  backup-script --help                    # Show help"
    echo "  backup-script                          # Interactive mode"
    echo "  backup-script /source /dest            # Command line mode"
    echo "  backup-script --list /backup/dir       # List existing backups"
    echo ""
    echo "Configuration:"
    if check_root && [[ "${1:-}" == "--system" ]]; then
        echo "  System config: /etc/backup-script/config.conf"
    else
        echo "  User config: $CONFIG_DIR/config.conf"
    fi
    echo ""
    print_status "Happy backing up!"
}

# Run main function
main "$@"