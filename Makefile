# 🛠️ Easy Setup Commands for Your Backup Buddy!

.PHONY: install install-user install-system uninstall test clean help

# Default target - show help
all: help

# Install just for you
install-user:
	@echo "🏠 Setting up your backup buddy just for you..."
	@chmod +x install.sh
	@./install.sh --user

# Install for everyone on this computer (needs admin powers)
install-system:
	@echo "🌍 Setting up your backup buddy for everyone..."
	@chmod +x install.sh
	@sudo ./install.sh --system

# Default install (just for you)
install: install-user

# Remove everything
uninstall:
	@echo "👋 Saying goodbye to your backup buddy..."
	@chmod +x install.sh
	@./install.sh --uninstall

# Add a desktop shortcut (Linux only)
desktop:
	@echo "🖥️ Creating a desktop shortcut..."
	@chmod +x install.sh
	@./install.sh --desktop

# Test if everything works
test:
	@echo "🧪 Testing your backup buddy..."
	@chmod +x simple-backup.sh
	@./simple-backup.sh --help
	@echo "🎉 Everything works perfectly!"

# Make files runnable
chmod:
	@echo "🔑 Making scripts executable..."
	@chmod +x simple-backup.sh
	@chmod +x install.sh

# Clean up mess
clean:
	@echo "🧹 Cleaning up temporary files..."
	@rm -f *.log
	@rm -f backup_*.tar.gz

# Show this help
help:
	@echo "🎒 Your Backup Buddy - Quick Setup Guide"
	@echo "========================================"
	@echo ""
	@echo "What can I help you with?"
	@echo "  install        📥 Set up for just you (recommended!)"
	@echo "  install-system 🌍 Set up for everyone (needs admin)"
	@echo "  uninstall      👋 Remove everything"
	@echo "  desktop        🖥️ Add desktop shortcut (Linux)"
	@echo "  test           🧪 Check if everything works"
	@echo "  clean          🧹 Clean up temporary files"
	@echo "  help           ❓ Show this friendly help"
	@echo ""
	@echo "Try these:"
	@echo "  make install         # Perfect for getting started!"
	@echo "  make test           # Make sure everything works"
	@echo ""
	@echo "Need more help? Check README.md! 😊"