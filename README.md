# Simple Backup Script

## Overview

The Simple Backup Script is a straightforward Bash script for backing up a directory. It compresses the specified directory into a `.tar.gz` archive, using the current date and time to name the backup file, making it an ideal learning tool for basic scripting, user interaction, and file handling.

## Features

- Compresses and backs up an entire directory.
- Utilizes the current date and time for unique backup filenames.
- Simple user interaction for specifying source and backup directories.

## Prerequisites

- Bash shell
- `tar` command available on Unix/Linux systems

## Usage

To use the script, you need to:

1. Make the script executable:

```bash
chmod +x simple-backup.sh
```

2. Execute the script and follow the on-screen prompts:

```bash
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
