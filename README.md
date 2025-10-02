# Advanced Backup System

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Version](https://img.shields.io/badge/version-2.0.0-brightgreen.svg)](https://github.com)

**Author:** Mir Hasibul Hasan Rahat

## Overview

This is a **comprehensive backup solution** designed to automate and simplify the process of protecting important data. The system provides enterprise-level backup capabilities through an intuitive interface, making it suitable for both individual users and organizations.

## What This System Does

The Advanced Backup System is a modular, intelligent backup tool that:

- **Creates compressed archives** of directories using industry-standard tar.gz format
- **Implements intelligent file naming** with timestamp-based unique identifiers
- **Manages storage automatically** through configurable retention policies
- **Provides comprehensive logging** for audit trails and troubleshooting
- **Offers multiple operation modes** for different user skill levels and automation needs
- **Includes restoration capabilities** for complete data recovery workflows

## Key Value Propositions

- **Data Protection**: Prevents data loss through automated backup creation
- **Storage Efficiency**: Reduces storage requirements through intelligent compression
- **Operational Simplicity**: Eliminates complex backup procedures with user-friendly interfaces
- **Scalability**: Handles both small personal directories and large organizational datasets
- **Reliability**: Includes error handling, validation, and comprehensive logging
- **Flexibility**: Supports both interactive and command-line operation modes

## Quick Start

### Installation
```bash
# Automated installation for current user
make install

# System-wide installation (requires admin privileges)
make install-system
```

### Basic Usage
```bash
# Interactive mode - guided backup creation
backup-script

# Direct command-line usage
backup-script /source/directory /backup/destination

# List existing backups
backup-script --list /backup/directory
```

## Core Features

### Backup Management
- **Automated Archive Creation**: Creates compressed tar.gz archives with optimal compression
- **Intelligent Naming**: Timestamp-based file naming prevents overwrites and ensures chronological ordering
- **Validation & Verification**: Built-in archive integrity checking and validation processes
- **Progress Monitoring**: Real-time progress indicators for long-running backup operations

### Storage Management  
- **Retention Policies**: Configurable rules for automatic cleanup of outdated backups
- **Space Optimization**: Intelligent compression algorithms to minimize storage requirements
- **Flexible Storage**: Support for local directories, network paths, and custom storage locations

### Operations & Monitoring
- **Comprehensive Logging**: Detailed activity logs with timestamps for audit and troubleshooting
- **Multiple Interface Modes**: Interactive guided mode and command-line automation support
- **Error Handling**: Robust error detection, reporting, and recovery mechanisms
- **Restoration Tools**: Complete backup restoration with selective file recovery options

### Configuration & Customization
- **Configuration Management**: Centralized configuration file for all operational parameters
- **User Profiles**: Support for multiple backup profiles and custom settings
- **Extensible Design**: Modular architecture allows for easy feature extensions

## System Architecture

The system follows a modular architecture pattern for maintainability and extensibility:

```
├── simple-backup.sh    # Main application entry point and orchestration
├── config.sh          # Configuration management and validation
├── utils.sh           # Utility functions and helper methods
├── backup.sh           # Core backup engine and file operations
├── config.conf         # Default system configuration parameters
├── install.sh          # Automated installation and setup script
├── Makefile           # Build automation and deployment commands
├── README.md          # System documentation and usage guide
├── DEMO_OUTPUT.md     # Example outputs and usage demonstrations
└── GIT_GUIDE.md       # Development and version control guidelines
```

### Design Principles
- **Separation of Concerns**: Each module handles specific functionality domains
- **Configuration-Driven**: All operational parameters externalized to configuration files
- **Error Resilience**: Comprehensive error handling and graceful failure recovery
- **Extensibility**: Plugin-ready architecture for feature additions
| **Customizable** | Personal config file for all your preferences | Set it once, works perfectly forever |
| **Restore Feature** | Easily unpack backups when needed | Get your files back in seconds |
| **Bulletproof** | Handles errors gracefully with helpful messages | No mysterious crashes or lost files |ian

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Version](https://img.shields.io/badge/version-2.0.0-brightgreen.svg)](https://github.com)

> **Never lose your important files again!** A smart, friendly backup tool that makes protecting your data as easy as saying "please backup my stuff." 

## 🌟 What is this?

Backup Buddy is a **smart backup system** that turns the scary task of backing up files into something fun and automatic! It's like having a super organized friend who:

- � **Safely compresses your files** into space-saving archives
- 🏷️ **Names everything perfectly** so you always know when each backup was made
- 🧹 **Keeps things tidy** by automatically removing old backups
- 📝 **Tracks everything** in a detailed log
- 🔄 **Brings files back** when you need to restore them
- � **Talks like a human** instead of throwing scary computer messages at you

**Perfect for:** Students protecting homework, developers safeguarding code, or anyone who's ever lost important files! 🎯

## Quick Start (Get backing up in 30 seconds!)

```bash
# 1. Super easy installation
make install

# 2. Start backing up immediately!
backup-script

# 3. That's it! Follow the friendly prompts 😊
```

## � What Makes This Special?

| Feature | What It Does | Why You'll Love It |
|---------|--------------|-------------------|
| 🤖 **Smart Automation** | Automatically names files with timestamps | Never accidentally overwrite backups |
| 🧹 **Auto-Cleanup** | Removes old backups based on your rules | Your storage won't fill up with ancient backups |
| � **Activity Log** | Records every backup with timestamps | Always know what happened and when |
| � **Two Usage Modes** | Interactive questions OR command-line | Works for beginners and power users |
| 🎛️ **Customizable** | Personal config file for all your preferences | Set it once, works perfectly forever |
| � **Restore Feature** | Easily unpack backups when needed | Get your files back in seconds |
| 🛡️ **Bulletproof** | Handles errors gracefully with helpful messages | No mysterious crashes or lost files |

## 📦 Project Structure

```
backup-buddy/
├── 🚀 simple-backup.sh    # Main program (your entry point)
├── ⚙️ config.sh          # Settings manager
├── 🛠️ utils.sh           # Helper toolkit 
├── 💾 backup.sh           # Core backup engine
├── 📝 config.conf         # Your personal preferences
├── 🔧 install.sh          # Easy installer
├── ⚡ Makefile           # One-command setup
├── 📖 README.md          # This guide
├── 🎬 DEMO_OUTPUT.md     # See what it looks like in action
└── � GIT_GUIDE.md       # Git tips for developers
```

> **Modular Design:** Each file has one job and does it well - making the code easy to understand, modify, and extend!

## Installation & Deployment

### Prerequisites
- Unix-like operating system (Linux, macOS, or Windows WSL)
- Bash shell version 4.0 or higher
- Standard Unix utilities: `tar`, `gzip`, `find`
- Appropriate file system permissions for target directories

### Installation Methods

#### Automated Installation (Recommended)
```bash
# User-specific installation
make install

# System-wide installation (requires administrative privileges)
make install-system
```

#### Manual Installation
```bash
# Prepare installation files
chmod +x simple-backup.sh install.sh

# User-specific deployment
./install.sh --user

# System-wide deployment
sudo ./install.sh --system
```

#### Development/Testing Mode
```bash
# Direct execution without installation
chmod +x simple-backup.sh
./simple-backup.sh --help
```

## Usage Guide

### Interactive Mode
The system provides a guided interface for users who prefer step-by-step assistance:
```bash
backup-script
# Follow the interactive prompts to configure and execute backups
```

### Command-Line Interface
For automation and advanced users, direct command-line operation is supported:

```bash
# Basic backup operation
backup-script /source/directory /destination/directory

# Use default backup location
backup-script /source/directory

# Verbose output for monitoring
backup-script --verbose /source /destination

# Silent operation for automation
backup-script --quiet /source /destination

# List existing backups
backup-script --list /backup/directory

# Restore from backup
backup-script --restore backup_file.tar.gz /restore/location

# Custom configuration file
backup-script --config custom.conf /source /destination
```

### Command Reference

| Option | Description | Use Case |
|--------|-------------|----------|
| `--help` | Display usage information and available options | Getting started, reference |
| `--verbose` | Enable detailed progress and debugging output | Monitoring, troubleshooting |
| `--quiet` | Suppress non-essential output messages | Automation, scripting |
| `--list` | Display existing backups in specified directory | Backup management, verification |
| `--restore` | Extract and restore files from backup archive | Data recovery, file restoration |
| `--config` | Specify custom configuration file path | Multiple environments, custom settings |
| `--create-config` | Generate configuration file template | Initial setup, customization |
| `--no-cleanup` | Disable automatic cleanup for current operation | Debugging, special circumstances |
| `--no-log` | Disable logging for current operation | Privacy, minimal footprint |

## Usage

## Configuration Management

The system uses a centralized configuration file (`config.conf`) for operational parameters:

### Core Settings
```bash
# Directory Configuration
DEFAULT_SOURCE_DIR="/home/user/Documents"    # Default source directory
DEFAULT_BACKUP_DIR="/home/user/Backups"     # Default backup destination

# Archive Settings  
COMPRESSION_LEVEL=6                          # Compression level (1-9, balanced default)
DATE_FORMAT="%Y-%m-%d_%H-%M-%S"             # Timestamp format for backup files

# Retention Management
ENABLE_CLEANUP=true                          # Enable automatic cleanup
KEEP_BACKUPS_COUNT=10                       # Maximum number of backups to retain
KEEP_BACKUPS_DAYS=30                        # Maximum age of backups in days

# Operational Settings
ENABLE_LOGGING=true                          # Enable comprehensive logging
SHOW_PROGRESS=true                          # Display progress indicators
VERBOSE=false                               # Enable verbose output mode
```

### Configuration Best Practices
- **Environment Separation**: Use different configuration files for development, testing, and production
- **Path Validation**: Ensure all configured paths exist and have appropriate permissions  
- **Retention Tuning**: Balance storage requirements with recovery needs
- **Logging Strategy**: Enable logging for production environments, consider privacy implications

## System Output Examples

### Backup Operation
```
Advanced Backup System v2.0.0
Author: Mir Hasibul Hasan Rahat
======================================

Configuration loaded: /etc/backup-system/config.conf
Source directory: /home/user/projects
Destination: /backups/backup_2025-10-02_14-30-15.tar.gz
Compression level: 6

Initializing backup process...
Validating source directory: /home/user/projects [OK]
Validating destination: /backups [OK]
Estimating backup size: 2.1GB

Creating backup archive...
Progress: ████████████████████████████████ 100%

Backup completed successfully
  Archive: backup_2025-10-02_14-30-15.tar.gz
  Original size: 2.1GB
  Compressed size: 847MB (60% compression)
  Duration: 2m 34s
  Location: /backups

Retention policy applied: 3 old backups removed
Operation logged to: backup.log
```

### Backup Inventory
```
Backup Inventory Report
=======================
Location: /backups
Generated: 2025-10-02 14:35:22

backup_2025-10-02_14-30-15.tar.gz    847MB     2025-10-02 14:30:15
backup_2025-10-01_09-15-30.tar.gz    731MB     2025-10-01 09:15:30  
backup_2025-09-30_16-45-22.tar.gz    892MB     2025-09-30 16:45:22
backup_2025-09-29_11-20-05.tar.gz    785MB     2025-09-29 11:20:05

Total archives: 4
Total storage used: 3.2GB
Oldest backup: 2025-09-29 11:20:05
Newest backup: 2025-10-02 14:30:15
```

## Use Cases and Applications

### Personal Data Protection
- **Document Backup**: Protect important documents, presentations, and personal files
- **Project Archives**: Maintain versioned backups of creative projects and work files  
- **System Configuration**: Backup system configurations and customizations

### Development Environments
- **Source Code Protection**: Create timestamped backups before major changes
- **Build Artifacts**: Archive compiled applications and deployment packages
- **Database Snapshots**: Backup development databases and test data

### Enterprise Applications
- **Departmental Data**: Automated backup of team directories and shared resources
- **Compliance Requirements**: Maintain audit trails and data retention compliance
- **Disaster Recovery**: Part of comprehensive business continuity planning

## Technical Specifications

### Performance Characteristics
- **Compression Ratio**: Typically 40-70% size reduction depending on data types
- **Processing Speed**: ~50-200MB/s depending on compression level and storage medium
- **Memory Usage**: Minimal memory footprint, suitable for resource-constrained environments
- **Scalability**: Handles directories from MB to multi-TB ranges

### Security Considerations
- **File Permissions**: Preserves original file permissions and ownership where possible
- **Access Control**: Respects system access controls and user permissions
- **Log Security**: Configurable logging levels to balance monitoring with privacy
- **Data Integrity**: Built-in verification to ensure backup completeness

## Troubleshooting and Support

### Common Issues
- **Permission Errors**: Ensure read access to source and write access to destination
- **Storage Space**: Monitor available disk space in backup destinations
- **Path Issues**: Verify all configured paths exist and are accessible
- **Dependencies**: Confirm required system utilities are installed and accessible

### Getting Help
- **Documentation**: Comprehensive examples in `DEMO_OUTPUT.md`
- **Configuration**: Setup guidance in `GIT_GUIDE.md`
- **Command Reference**: Built-in help via `backup-script --help`
- **Issue Reporting**: Submit detailed bug reports for prompt resolution

## Contributing and Development

### Contributing Guidelines
1. **Bug Reports**: Provide detailed reproduction steps and system information
2. **Feature Requests**: Include use cases and implementation suggestions
3. **Code Contributions**: Follow existing code style and include appropriate tests
4. **Documentation**: Help improve clarity and completeness of documentation

### Development Setup
```bash
# Clone the repository
git clone [repository-url]
cd backup-system

# Make scripts executable
chmod +x *.sh

# Run tests
./test-suite.sh
```

## License and Attribution

**License:** MIT License - See LICENSE file for complete terms  
**Author:** Mir Hasibul Hasan Rahat  
**Version:** 2.0.0  
**Compatibility:** Bash 4.0+, Linux/macOS/WSL

---

*This project demonstrates advanced shell scripting techniques, modular architecture design, and enterprise-ready backup solution development.*

## File Structure

After running the script, your backup directory will contain:

```
backup_directory/
├── backup_2025-10-02_14-30-15.tar.gz
├── backup_2025-10-01_09-15-30.tar.gz
├── backup_2025-09-30_16-45-22.tar.gz
└── backup.log
```

## Logging

The script creates detailed logs in `backup.log` with the following information:
- Timestamp of each operation
- Success/failure status
- File sizes and locations
- Cleanup operations
- Error messages

Example log entries:
```
[2025-10-02 14:30:15] [INFO] Starting backup of '/home/user/documents' to '/backups/backup_2025-10-02_14-30-15.tar.gz'
[2025-10-02 14:30:45] [INFO] Backup completed successfully. Size: 2.3G
[2025-10-02 14:30:46] [INFO] Starting cleanup of old backups in /backups
[2025-10-02 14:30:46] [INFO] Removed old backup: backup_2025-09-15_10-20-30.tar.gz
```

## Automatic Cleanup

The script automatically manages backup retention based on two criteria:

1. **Count-based**: Keeps only the N most recent backups (`KEEP_BACKUPS_COUNT`)
2. **Age-based**: Removes backups older than X days (`KEEP_BACKUPS_DAYS`)

Both policies can be enabled simultaneously for comprehensive backup management.

## Examples

### Basic Backup
```bash
# Interactive backup
./simple-backup.sh

# Command line backup
./simple-backup.sh /home/user/projects /backups/projects
```

### Advanced Usage
```bash
# Verbose backup with custom config
./simple-backup.sh -v -c my-config.conf /important/data

# Quiet backup without cleanup
./simple-backup.sh -q --no-cleanup /temp/files /backups/temp

# One-time backup without logging
./simple-backup.sh --no-log /sensitive/data /secure/backups
```

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure you have read access to source directory and write access to backup directory
2. **Disk Space**: Check available space in backup directory before running
3. **Missing Dependencies**: Ensure `tar` and `find` commands are available

### Debug Mode
Use verbose mode for detailed troubleshooting:
```bash
./simple-backup.sh -v /path/to/source
```

Check the log file for detailed error information:
```bash
tail -f backup.log
```

## Version History

### v2.0.0 (Current)
- Added configuration file support
- Implemented automatic backup cleanup/rotation
- Added comprehensive logging functionality
- Command line arguments support
- Progress indicators and verbose mode
- Enhanced error handling and validation

### v1.0.0
- Basic directory backup functionality
- Interactive user prompts
- Simple tar.gz compression

## Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

## License

MIT License - see LICENSE file for details.

## Author

BASHCAVE
./simple-backup.sh
```

## How It Works

- Upon execution, the script prompts the user to input the source directory (the directory to back up) and the backup directory (where the backup file will be stored).
- It generates a unique backup filename by appending the current date and time to the 'backup' keyword, ensuring that each backup file is uniquely identifiable.
- The `tar` command is used to compress the source directory into a `.tar.gz` file, which is then saved to the backup directory. The `-C` option changes the directory to the source directory before performing the backup to ensure paths in the backup are relative to the source directory.

## Important Notes

- Verify the paths to the source and backup directories to avoid errors.
- The script does not delete old backups. Consider implementing a cleanup mechanism if you run backups frequently.
- Ensure you have sufficient permissions for the directories involved and enough disk space in the backup location.
