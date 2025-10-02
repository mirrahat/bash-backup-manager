# Makefile for Enhanced Backup Script

.PHONY: install install-user install-system uninstall test clean help

# Default target
all: help

# Install for current user
install-user:
	@echo "Installing for current user..."
	@chmod +x install.sh
	@./install.sh --user

# Install system-wide (requires sudo)
install-system:
	@echo "Installing system-wide..."
	@chmod +x install.sh
	@sudo ./install.sh --system

# Default install (user)
install: install-user

# Uninstall
uninstall:
	@echo "Uninstalling..."
	@chmod +x install.sh
	@./install.sh --uninstall

# Create desktop shortcut
desktop:
	@echo "Creating desktop shortcut..."
	@chmod +x install.sh
	@./install.sh --desktop

# Test the script
test:
	@echo "Running basic tests..."
	@chmod +x simple-backup.sh
	@./simple-backup.sh --help
	@echo "Test completed successfully!"

# Make all scripts executable
chmod:
	@echo "Setting executable permissions..."
	@chmod +x simple-backup.sh
	@chmod +x install.sh

# Clean up temporary files
clean:
	@echo "Cleaning up..."
	@rm -f *.log
	@rm -f backup_*.tar.gz

# Show help
help:
	@echo "Enhanced Backup Script - Makefile"
	@echo "=================================="
	@echo ""
	@echo "Available targets:"
	@echo "  install        Install for current user (default)"
	@echo "  install-user   Install for current user only"
	@echo "  install-system Install system-wide (requires sudo)"
	@echo "  uninstall      Remove installation"
	@echo "  desktop        Create desktop shortcut"
	@echo "  test           Test the script"
	@echo "  chmod          Make scripts executable"
	@echo "  clean          Clean temporary files"
	@echo "  help           Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make install         # Install for current user"
	@echo "  make install-system  # Install system-wide"
	@echo "  make test           # Test the installation"