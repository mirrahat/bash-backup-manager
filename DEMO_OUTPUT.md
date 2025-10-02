# Enhanced Backup Script - Sample Output Examples

## Help Output
```
$ backup-script --help

Enhanced Backup Script v2.0.0
Usage: simple-backup.sh [OPTIONS] [SOURCE_DIR] [BACKUP_DIR]

Options:
  -h, --help          Show this help message
  -v, --verbose       Enable verbose output
  -q, --quiet         Quiet mode (minimal output)
  -l, --list          List existing backups in specified directory
  -r, --restore FILE TARGET  Restore backup file to target directory
  -c, --config FILE   Use custom configuration file
  --create-config [FILE]  Create sample configuration file
  --no-cleanup        Disable automatic cleanup
  --no-log           Disable logging

Examples:
  simple-backup.sh                           # Interactive mode
  simple-backup.sh /home/user/docs /backups  # Backup docs to /backups
  simple-backup.sh -v /home/user/docs        # Verbose backup to default location
```

## Interactive Mode Output
```
$ backup-script

Enhanced Backup Script v2.0.0
=================================
Source directory (default: /home/user/Documents):
Enter path or press Enter for default: /home/user/projects

Backup directory (default: /home/user/Backups):
Enter path or press Enter for default: 

Creating backup...
Source: /home/user/projects
Destination: /home/user/Backups/backup_2025-10-02_14-30-15.tar.gz
Compression level: 6

............................

✓ Backup completed successfully!
  File: backup_2025-10-02_14-30-15.tar.gz
  Size: 2.3G
  Location: /home/user/Backups
```

## Verbose Mode Output
```
$ backup-script -v /home/user/documents /backups

Enhanced Backup Script v2.0.0
=================================
Current Configuration:
  Source Directory: /home/user/Documents
  Backup Directory: /home/user/Backups
  Compression Level: 6
  Date Format: %Y-%m-%d_%H-%M-%S
  Enable Cleanup: true
  Keep Backups Count: 10
  Keep Backups Days: 30
  Enable Logging: true
  Log File: backup.log
  Show Progress: true
  Verbose: true

[INFO] Loading configuration from: /home/user/.backup-script/config.conf
[INFO] Starting backup of '/home/user/documents' to '/backups/backup_2025-10-02_14-30-15.tar.gz'
[INFO] Created backup directory: /backups

Creating backup...
Source: /home/user/documents
Destination: /backups/backup_2025-10-02_14-30-15.tar.gz
Compression level: 6

............................

[INFO] Backup completed successfully. Size: 2.3G
[INFO] Starting cleanup of old backups in /backups
[INFO] Removed old backup (count limit): backup_2025-09-15_10-20-30.tar.gz

✓ Backup completed successfully!
  File: backup_2025-10-02_14-30-15.tar.gz
  Size: 2.3G
  Location: /backups
```

## List Backups Output
```
$ backup-script -l /backups

Enhanced Backup Script v2.0.0
=================================
Existing backups in /backups:
=======================================
Filename                       Size       Date
--------                       ----       ----
backup_2025-10-02_14-30-15.tar.gz  2.3G      2025-10-02 14:30:15
backup_2025-10-01_09-15-30.tar.gz  1.8G      2025-10-01 09:15:30
backup_2025-09-30_16-45-22.tar.gz  2.1G      2025-09-30 16:45:22
backup_2025-09-29_11-20-05.tar.gz  1.9G      2025-09-29 11:20:05

Total backups: 4
```

## Sample Log File (backup.log)
```
[2025-10-02 14:30:15] [INFO] Loading configuration from: /home/user/.backup-script/config.conf
[2025-10-02 14:30:15] [INFO] Starting backup of '/home/user/documents' to '/backups/backup_2025-10-02_14-30-15.tar.gz'
[2025-10-02 14:30:45] [INFO] Backup completed successfully. Size: 2.3G
[2025-10-02 14:30:46] [INFO] Starting cleanup of old backups in /backups
[2025-10-02 14:30:46] [INFO] Removed old backup (count limit): backup_2025-09-15_10-20-30.tar.gz
[2025-10-02 14:32:10] [INFO] Starting restore from '/backups/backup_2025-10-02_14-30-15.tar.gz' to '/restore/location'
[2025-10-02 14:32:45] [INFO] Restore completed successfully
```

## Installation Output
```
$ make install

Installing for current user...
Enhanced Backup Script Installer
[INFO] Checking dependencies...
[INFO] All dependencies found.
Installing Enhanced Backup Script (User-only)
[INFO] Created user config at /home/user/.backup-script/config.conf
[INFO] User installation completed.
[WARN] Make sure /home/user/.local/bin is in your PATH.
[INFO] You can add this line to your ~/.bashrc or ~/.zshrc:
    export PATH="$HOME/.local/bin:$PATH"

Installation Summary
Enhanced Backup Script has been installed successfully!

Quick Start:
  backup-script --help                    # Show help
  backup-script                          # Interactive mode
  backup-script /source /dest            # Command line mode
  backup-script --list /backup/dir       # List existing backups

Configuration:
  User config: /home/user/.backup-script/config.conf

[INFO] Happy backing up!
```