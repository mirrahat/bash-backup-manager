# Enhanced Backup Script

## Overview

The Enhanced Backup Script is a feature-rich Bash script for backing up directories with advanced functionality. It compresses the specified directory into a `.tar.gz` archive with configurable settings, automatic cleanup, logging, and multiple usage modes. This makes it an excellent tool for both learning and production use.

## Features

### Core Features
- **Directory Compression**: Compresses and backs up entire directories using tar.gz format
- **Unique Filenames**: Uses current date and time for unique backup filenames
- **Flexible Input**: Supports both interactive prompts and command-line arguments
- **Default Directories**: Configurable default source and backup directories

### Advanced Features
- **Configuration File**: External config file (`config.conf`) for persistent settings
- **Automatic Cleanup**: Removes old backups based on count or age policies
- **Comprehensive Logging**: Detailed logging to `backup.log` with timestamps
- **Progress Indicators**: Visual feedback during backup creation
- **Verbose Mode**: Detailed output for troubleshooting
- **Custom Compression**: Configurable compression levels (1-9)
- **Error Handling**: Robust error checking and reporting

## Project Structure

The script is now modularized for better maintainability:

```
simple-backup/
├── simple-backup.sh    # Main entry point
├── config.sh          # Configuration loader
├── utils.sh            # Utility functions (logging, cleanup, validation)
├── backup.sh           # Core backup functionality
├── config.conf         # Configuration file
├── install.sh          # Installation script
├── Makefile           # Build automation
├── README.md          # Documentation
└── LICENSE            # License file
```

## Installation

### Quick Install (Recommended)
```bash
# Install for current user
make install

# Or install system-wide (requires sudo)
make install-system
```

### Manual Installation
```bash
# Make scripts executable
chmod +x simple-backup.sh install.sh

# Install for current user
./install.sh --user

# Or install system-wide (requires sudo)
sudo ./install.sh --system
```

## Prerequisites

- Bash shell (version 4.0 or higher recommended)
- `tar` command available on Unix/Linux systems
- `find` command for cleanup functionality
- `gzip` for compression
- Write permissions to backup and log directories

## Configuration

The script uses a `config.conf` file for default settings. You can customize:

```bash
# Default directories
DEFAULT_SOURCE_DIR="/home/user/Documents"
DEFAULT_BACKUP_DIR="/home/user/Backups"

# Backup settings
COMPRESSION_LEVEL=6          # Compression level (1-9)
DATE_FORMAT="%Y-%m-%d_%H-%M-%S"

# Retention settings
ENABLE_CLEANUP=true          # Enable automatic cleanup
KEEP_BACKUPS_COUNT=10        # Number of recent backups to keep
KEEP_BACKUPS_DAYS=30         # Delete backups older than X days

# Logging settings
ENABLE_LOGGING=true          # Enable logging
LOG_FILE="backup.log"        # Log file name

# Display settings
SHOW_PROGRESS=true           # Show progress indicators
VERBOSE=false                # Enable verbose output
```

## Usage

### 1. Make the script executable:

```bash
chmod +x simple-backup.sh
```

### 2. Usage Methods:

#### Interactive Mode (Default)
```bash
backup-script
# Or if not installed: ./simple-backup.sh
```
Follow the prompts to specify source and backup directories.

#### Command Line Arguments
```bash
# Basic usage with directories
backup-script /path/to/source /path/to/backup

# Using default backup directory
backup-script /path/to/source

# Verbose mode
backup-script -v /path/to/source /path/to/backup

# Quiet mode
backup-script -q /path/to/source /path/to/backup

# List existing backups
backup-script -l /backup/directory

# Restore from backup
backup-script -r /path/to/backup.tar.gz /restore/location

# Custom configuration file
backup-script -c /path/to/custom.conf /path/to/source

# Create sample configuration
backup-script --create-config my-config.conf

# Disable cleanup for this run
backup-script --no-cleanup /path/to/source

# Disable logging for this run
backup-script --no-log /path/to/source
```

#### Help and Options
```bash
backup-script --help
```

## Command Line Options

| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message and exit |
| `-v, --verbose` | Enable verbose output for detailed information |
| `-q, --quiet` | Quiet mode with minimal output |
| `-l, --list` | List existing backups in specified directory |
| `-r, --restore FILE TARGET` | Restore backup file to target directory |
| `-c, --config FILE` | Use custom configuration file |
| `--create-config [FILE]` | Create sample configuration file |
| `--no-cleanup` | Disable automatic cleanup for this run |
| `--no-log` | Disable logging for this run |

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
