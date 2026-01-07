#!/bin/bash
# M-DOD Backup and Recovery Script
set -e

BACKUP_DIR="${BACKUP_DIR:-/opt/mdod/backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="mdod_backup_$TIMESTAMP"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo "=== M-DOD Backup and Recovery System ==="
echo ""

case "${1:-help}" in
    backup)
        echo "Starting backup process..."
        mkdir -p "$BACKUP_PATH"
        
        # Backup configurations
        echo "1. Backing up configurations..."
        tar -czf "$BACKUP_PATH/config.tar.gz" \
            docker/ \
            monitoring/ \
            security/ \
            workflows/ \
            .github/ \
            --exclude="*.log" \
            --exclude="*.tmp"
        
        # Backup critical source files
        echo "2. Backing up source code..."
        find . -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.go" -o -name "*.cpp" \
            -o -name "*.sh" -o -name "*.yml" -o -name "*.yaml" -o -name "*.json" \
            | tar -czf "$BACKUP_PATH/source_code.tar.gz" -T -
        
        # Create backup manifest
        echo "3. Creating backup manifest..."
        cat > "$BACKUP_PATH/manifest.json" << MANIFESTEOF
{
    "backup_name": "$BACKUP_NAME",
    "timestamp": "$(date -Iseconds)",
    "system": "$(uname -a)",
    "mdod_version": "1.0.0",
    "components": [
        "configurations",
        "source_code",
        "workflows",
        "monitoring"
    ],
    "backup_size": "$(du -sh $BACKUP_PATH | cut -f1)"
}
MANIFESTEOF
        
        echo ""
        echo "=== BACKUP COMPLETE ==="
        echo "Backup saved to: $BACKUP_PATH"
        echo "Contents:"
        ls -la "$BACKUP_PATH/"
        echo ""
        echo "To restore: ./backup/backup_recovery.sh restore $BACKUP_PATH"
        ;;
        
    restore)
        if [ -z "$2" ]; then
            echo "Error: Please specify backup path to restore"
            echo "Usage: $0 restore /path/to/backup"
            exit 1
        fi
        
        RESTORE_PATH="$2"
        if [ ! -d "$RESTORE_PATH" ]; then
            echo "Error: Backup directory not found: $RESTORE_PATH"
            exit 1
        fi
        
        echo "Starting restore process from: $RESTORE_PATH"
        echo "WARNING: This will overwrite existing files!"
        read -p "Continue? (y/N): " confirm
        
        if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
            echo "Restore cancelled."
            exit 0
        fi
        
        echo "1. Restoring configurations..."
        tar -xzf "$RESTORE_PATH/config.tar.gz" -C ./
        
        echo "2. Restoring source code..."
        tar -xzf "$RESTORE_PATH/source_code.tar.gz" -C ./
        
        echo ""
        echo "=== RESTORE COMPLETE ==="
        echo "System restored from: $(basename $RESTORE_PATH)"
        ;;
        
    list)
        if [ -d "$BACKUP_DIR" ]; then
            echo "Available backups in $BACKUP_DIR:"
            ls -la "$BACKUP_DIR"/
        else
            echo "No backups found."
        fi
        ;;
        
    *)
        echo "Usage: $0 {backup|restore|list}"
        echo ""
        echo "Commands:"
        echo "  backup   - Create a new backup of M-DOD system"
        echo "  restore  - Restore from specified backup"
        echo "  list     - List available backups"
        echo ""
        echo "Environment:"
        echo "  BACKUP_DIR - Backup directory (default: /opt/mdod/backups)"
        exit 1
        ;;
esac
