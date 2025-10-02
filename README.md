# 📦 Simple Backup Tool

## Hey there! 👋

Tired of losing your important files? This friendly backup tool has got your back! 

Think of it as your personal assistant that:
- 🗂️ Safely packs up your files into neat little packages
- 🧹 Automatically cleans up old backups so your storage doesn't explode
- 📝 Keeps a diary of everything it does (in case you're curious)
- 🔄 Can even unpack your files when you need them back

**Perfect for:** Students, developers, or anyone who values their digital stuff!

## What makes this special? ✨

### The Basics (Everyone loves these!)
- 📁 **Squishes folders**: Takes any folder and makes it tiny (like a zip file, but better)
- 🕐 **Smart naming**: Never overwrites your backups - each one gets a unique timestamp
- 💬 **Two ways to use**: Ask questions as you go, or just tell it what to do
- 🏠 **Remembers your favorites**: Set your usual folders so you don't have to type them every time

### The Cool Stuff (You'll love these!)
- ⚙️ **Personal settings**: One config file to rule them all
- 🗑️ **Auto-cleanup**: Keeps your newest backups, tosses the old ones (you decide how many to keep!)
- 📔 **Backup diary**: Writes down everything it does with timestamps
- 📊 **Progress bars**: See what's happening as it works
- 🔍 **Detective mode**: Extra chatty output when things go wrong
- 💪 **Compression levels**: Make files smaller (1=fast, 9=tiny)
- 🛡️ **Error-proof**: Handles mistakes gracefully and tells you what happened

## What's in the box? 📦

Don't worry - I organized everything neatly for you:

```
📂 Your Backup Buddy/
├── 🚀 simple-backup.sh    # The main guy - start here!
├── ⚙️ config.sh          # Loads your personal settings
├── 🛠️ utils.sh           # Helper functions (the behind-the-scenes magic)
├── 💾 backup.sh           # Does the actual backup work
├── 📝 config.conf         # Your personal preferences file
├── 🔧 install.sh          # Easy setup script
├── ⚡ Makefile           # One-command installation
├── 📖 README.md          # This file you're reading!
└── 📄 LICENSE            # Legal stuff (it's free!)
```

## Getting Started 🚀

### Super Easy Setup (Recommended!)
```bash
# Just one command and you're done!
make install

# Want it available for everyone on your computer? (needs admin)
make install-system
```

### DIY Installation (If you like to be in control)
```bash
# First, make the files runnable
chmod +x simple-backup.sh install.sh

# Install just for you
./install.sh --user

# Install for everyone (needs admin powers)
sudo ./install.sh --system
```

## Do I have what I need? 🤔

Don't worry, you probably already have everything! You just need:

- **A Unix-like system** (Linux, Mac, or Windows with WSL)
- **Basic tools** that come with your system:
  - `bash` (to run the script)
  - `tar` (to squish files)
  - `gzip` (to make them smaller)
- **Permission** to read your files and write backups (you probably have this!)

## Make it yours! ⚙️

There's a friendly config file called `config.conf` where you can set your preferences:

```bash
# Where do your files usually live?
DEFAULT_SOURCE_DIR="/home/user/Documents"     # Your stuff folder
DEFAULT_BACKUP_DIR="/home/user/Backups"      # Where backups go

# How tight should we squeeze the files?
COMPRESSION_LEVEL=6          # 1=fast but big, 9=slow but tiny

# How should we name backup files?
DATE_FORMAT="%Y-%m-%d_%H-%M-%S"              # Like: 2025-10-02_14-30-15

# Keep things tidy automatically?
ENABLE_CLEANUP=true          # Yes, please clean up!
KEEP_BACKUPS_COUNT=10        # Keep my 10 newest backups
KEEP_BACKUPS_DAYS=30         # Delete anything older than 30 days

# Want to keep track of what happened?
ENABLE_LOGGING=true          # Write a diary of backups
LOG_FILE="backup.log"        # Call the diary this

# How chatty should it be?
SHOW_PROGRESS=true           # Show me what's happening
VERBOSE=false                # Don't be too chatty (change to true if curious!)
```

## Usage

## How do I use this thing? 🤷‍♀️

### The Friendly Way (Ask me questions!)
```bash
backup-script
# Or if you didn't install it yet: ./simple-backup.sh
```
I'll ask you what folder to backup and where to put it. Easy peasy!

### The Quick Way (For when you know what you want)
```bash
# Basic backup - tell me source and destination
backup-script /home/you/important-stuff /backups

# Just tell me what to backup (I'll use your default backup spot)
backup-script /home/you/projects

# Chatty mode - tell me everything you're doing
backup-script -v /home/you/documents /backups

# Quiet mode - just do it, don't tell me about it
backup-script -q /home/you/photos /backups

# What backups do I already have?
backup-script -l /backups

# Oops! I need my files back!
backup-script -r /backups/backup_2025-10-02_14-30-15.tar.gz /restore-here

# Use my special settings file
backup-script -c /path/to/my-special-config.conf /home/you/stuff

# Create a settings file template for me
backup-script --create-config my-settings.conf

# Just this once, don't clean up old backups
backup-script --no-cleanup /home/you/temporary-stuff

# Just this once, don't write to the log
backup-script --no-log /home/you/secret-stuff
```

### Lost? Get Help!
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
