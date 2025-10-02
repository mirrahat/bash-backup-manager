@echo off
REM demo.bat - Windows demonstration of the backup script features

echo Enhanced Backup Script - Windows Demo
echo ======================================
echo.

echo 1. Showing help output:
echo ------------------------
echo.
type nul > demo_help.txt
echo Enhanced Backup Script v2.0.0 >> demo_help.txt
echo Usage: simple-backup.sh [OPTIONS] [SOURCE_DIR] [BACKUP_DIR] >> demo_help.txt
echo. >> demo_help.txt
echo Options: >> demo_help.txt
echo   -h, --help          Show this help message >> demo_help.txt
echo   -v, --verbose       Enable verbose output >> demo_help.txt
echo   -q, --quiet         Quiet mode (minimal output) >> demo_help.txt
echo   -l, --list          List existing backups >> demo_help.txt
echo   -r, --restore       Restore from backup >> demo_help.txt
echo   -c, --config FILE   Use custom config file >> demo_help.txt
echo   --create-config     Create sample config >> demo_help.txt
echo   --no-cleanup        Disable cleanup >> demo_help.txt
echo   --no-log           Disable logging >> demo_help.txt

type demo_help.txt
echo.

echo 2. Project Structure:
echo --------------------
echo simple-backup/
echo ├── simple-backup.sh    # Main entry point
echo ├── config.sh          # Configuration loader
echo ├── utils.sh           # Utility functions
echo ├── backup.sh          # Core backup functionality
echo ├── config.conf        # Configuration file
echo ├── install.sh         # Installation script
echo ├── Makefile          # Build automation
echo ├── README.md         # Documentation
echo └── LICENSE           # License file
echo.

echo 3. Sample Configuration:
echo -----------------------
type config.conf
echo.

echo 4. Installation Commands:
echo ------------------------
echo make install           # Install for current user
echo make install-system    # Install system-wide (Linux/Mac)
echo ./install.sh --user    # Manual user installation
echo backup-script --help   # Show help after installation
echo.

echo Demo completed! Check DEMO_OUTPUT.md for detailed examples.
del demo_help.txt

pause