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

**Target Users:** Students, developers, system administrators, and anyone needing reliable data protection.

## Quick Start

```bash
# 1. Installation
make install

# 2. Run backup system
backup-script

# 3. Follow the interactive prompts
```

## Key Features

| Feature | Description | Benefits |
|---------|-------------|----------|
| **Smart Automation** | Automatically names files with timestamps | Never accidentally overwrite backups |
| **Auto-Cleanup** | Removes old backups based on your rules | Your storage won't fill up with ancient backups |
| **Activity Log** | Records every backup with timestamps | Always know what happened and when |
| **Two Usage Modes** | Interactive questions OR command-line | Works for beginners and power users |
| **Customizable** | Personal config file for all your preferences | Set it once, works perfectly forever |
| **Restore Feature** | Easily unpack backups when needed | Get your files back in seconds |
| **Bulletproof** | Handles errors gracefully with helpful messages | No mysterious crashes or lost files |

## Project Structure

```
backup-system/
 simple-backup.sh    # Main application entry point and orchestration
 config.sh          # Configuration management and validation
 utils.sh           # Utility functions and helper methods
 backup.sh           # Core backup engine and file operations
 config.conf         # Default system configuration parameters
 install.sh          # Automated installation and setup script
 Makefile           # Build automation and deployment commands
 README.md          # System documentation and usage guide
 DEMO_OUTPUT.md     # Example outputs and usage demonstrations
 GIT_GUIDE.md       # Development and version control guidelines
```

> **Modular Design:** Each file has one job and does it well - making the code easy to understand, modify, and extend!

## Installation & Deployment

### Prerequisites
- Unix-like operating system (Linux, macOS, or Windows WSL)
- Bash version 4.0 or higher
- Standard Unix utilities: tar, gzip, date, find

### Method 1: Automated Installation (Recommended)
```bash
# Clone or download the repository
git clone <repository-url>
cd simple-backup

# Run the automated installer
make install
# or alternatively:
chmod +x install.sh && ./install.sh
```

### Method 2: Manual Installation
```bash
# Make scripts executable
chmod +x simple-backup.sh config.sh utils.sh backup.sh

# Create symlink for global access
sudo ln -sf "$(pwd)/simple-backup.sh" /usr/local/bin/backup-script

# Verify installation
backup-script --version
```

### Method 3: Portable Mode
```bash
# Make executable and run directly
chmod +x simple-backup.sh
./simple-backup.sh
```

## Configuration

The system uses a configuration file (`config.conf`) for customizable settings:

```bash
# Edit configuration
nano config.conf

# Key settings:
DEFAULT_BACKUP_DIR="/home/$USER/Backups"    # Where to store backups
RETENTION_DAYS=30                           # How long to keep old backups
LOG_LEVEL="INFO"                           # Logging verbosity
COMPRESSION_LEVEL=6                        # Balance between speed and size
```

## Usage Examples

### Basic Interactive Mode
```bash
backup-script
# Follow the prompts to select source and destination
```

### Command Line Mode
```bash
# Backup specific directory
backup-script /path/to/important/files

# Backup with custom destination
backup-script /home/user/documents /backup/location

# Restore from backup
backup-script --restore /path/to/backup.tar.gz /restore/location
```

### Advanced Options
```bash
# Show help
backup-script --help

# Run with verbose logging
backup-script --verbose /path/to/backup

# Dry run (simulate without creating files)
backup-script --dry-run /path/to/backup

# Custom configuration file
backup-script --config /path/to/custom.conf
```

## Sample Output

When you run the backup system, you'll see clean, informative output:

```
=== Advanced Backup System v2.0 ===
Author: Mir Hasibul Hasan Rahat

[INFO] Starting backup process...
[INFO] Source: /home/user/documents (1.2GB)
[INFO] Destination: /home/user/Backups/documents_2024-01-15_14-30-45.tar.gz
[INFO] Compression: Level 6 (balanced)

Creating backup...   100%

[SUCCESS] Backup completed successfully!
[INFO] Final size: 256MB (79% compression)
[INFO] Time taken: 45 seconds
[INFO] Backup saved as: documents_2024-01-15_14-30-45.tar.gz
```

## Architecture & Design

### Modular Components

1. **simple-backup.sh** - Main orchestration layer
   - Handles argument parsing and user interaction
   - Coordinates between different modules
   - Provides the primary user interface

2. **config.sh** - Configuration management
   - Loads and validates configuration settings
   - Provides default values for all parameters
   - Handles custom configuration file loading

3. **utils.sh** - Utility functions
   - Logging and output formatting
   - File system operations and validation
   - Cleanup and maintenance tasks

4. **backup.sh** - Core backup engine
   - Archive creation and compression
   - Backup verification and integrity checking
   - Restoration and recovery operations

### Design Principles

- **Separation of Concerns**: Each module has a specific responsibility
- **Error Handling**: Graceful failure with informative messages  
- **User Experience**: Clear output and intuitive interaction
- **Maintainability**: Well-commented, readable code structure
- **Extensibility**: Easy to add new features and functionality

## Contributing

We welcome contributions to improve the backup system:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/improvement`
3. **Make your changes** with clear commit messages
4. **Test thoroughly** on different systems
5. **Submit a pull request** with description of changes

### Development Guidelines

- Follow existing code style and naming conventions
- Add comments for complex logic and functions
- Test on multiple bash versions and operating systems
- Update documentation for new features
- Ensure backwards compatibility when possible

## Troubleshooting

### Common Issues

**Permission Denied**
```bash
# Solution: Make scripts executable
chmod +x *.sh
```

**Command Not Found**
```bash
# Solution: Check if /usr/local/bin is in PATH
echo $PATH
# or use full path: /usr/local/bin/backup-script
```

**Backup Fails with "No Space Left"**
```bash
# Solution: Check available disk space
df -h
# Clean up old backups or choose different destination
```

**Configuration Not Loading**
```bash
# Solution: Check config file permissions and syntax
ls -la config.conf
# Ensure proper format (key=value pairs)
```

### Getting Help

- **Check the logs**: Look in the backup directory for `.log` files
- **Run with verbose mode**: Add `--verbose` flag for detailed output
- **Validate configuration**: Run `backup-script --check-config`
- **Review documentation**: See `DEMO_OUTPUT.md` for examples

## Technical Specifications

### System Requirements
- **OS**: Linux, macOS, BSD, or Windows Subsystem for Linux
- **Shell**: Bash 4.0+ (check with `bash --version`)
- **Storage**: Minimum 2x source data size for compression
- **Memory**: 64MB RAM for small backups, more for large datasets

### Performance Characteristics
- **Compression Ratio**: Typically 60-80% size reduction
- **Speed**: ~50MB/s on modern SSDs (varies by data type)
- **Scalability**: Tested with directories up to 100GB
- **Concurrency**: Single-threaded for data integrity

### Security Features
- **No network transmission**: All operations are local
- **Preserve permissions**: Maintains original file attributes  
- **Atomic operations**: Backups complete fully or not at all
- **Verification**: Optional integrity checking after backup

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

### Version 2.0.0
- Modular architecture with separated components
- Enhanced error handling and user feedback
- Configurable retention and cleanup policies
- Professional documentation and installation system

### Version 1.0.0
- Initial release with basic backup functionality
- Simple command-line interface
- Basic compression and file naming

---

**Developed by:** Mir Hasibul Hasan Rahat  
**Project Status:** Active Development  
**Last Updated:** 2024
