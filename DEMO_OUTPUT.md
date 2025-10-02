# 🎬 What does it look like when I work?

Here's what you'll see when you use your backup buddy!

## When you ask for help
```
$ backup-script --help

🎒 Your Friendly Backup Buddy v2.0.0
Hi! I'm here to help you backup your files safely and easily.

How to use me:
  backup-script                           # Just run me and I'll ask what you need!
  backup-script /your/files /backup/spot  # Tell me exactly what and where
  backup-script /your/files              # I'll use your default backup location

Special powers I have:
  -h, --help          Show this friendly help message
  -v, --verbose       Make me extra chatty about what I'm doing
  -q, --quiet         Make me work silently
  -l, --list          Show you what backups you already have
  -r, --restore       Bring back your files from a backup
  -c, --config FILE   Use your own special settings file
  --create-config     Make a new settings file template
  --no-cleanup        Skip cleaning up old backups this time
  --no-log           Don't write to my diary this time

Need more help? Check the README.md file - it's full of examples! 😊
```

## When I ask you questions (Interactive mode)
```
$ backup-script

🎒 Your Friendly Backup Buddy v2.0.0
=====================================
Hi there! Let's make a backup together! 😊

What folder would you like me to backup?
(Just press Enter to use: /home/user/Documents)
👉 /home/user/projects

Where should I put your backup?
(Just press Enter to use: /home/user/Backups)
👉 [You pressed Enter - using default]

Great! Here I go...
📂 Source: /home/user/projects
💾 Backup: /home/user/Backups/backup_2025-10-02_14-30-15.tar.gz
🗜️ Compression: Level 6 (nice balance!)

Working on it... 🔄
............................

🎉 All done! Your backup is safe and sound!
  📁 File: backup_2025-10-02_14-30-15.tar.gz
  📏 Size: 2.3G (pretty good compression!)
  📍 Location: /home/user/Backups

Your files are now safely backed up! 🛡️
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