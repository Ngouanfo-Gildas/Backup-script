#!/bin/bash

echo "### Execution Date: $(date "+%A %d %B %Y at %r")"

# backup directory to be set as parameter
BACKUP_DIR=$1

# Delete differential backups older than 7 days
find $BACKUP_DIR -name 'backup_diff_*' -type f -mtime +7 -exec rm -f {} \;

# Delete monthly backups older than 6 months
find $BACKUP_DIR -name 'backup_complet_*' -type f -mtime +30 -exec rm -f {} \;

# Delete monthly backups older than 6 months
find $BACKUP_DIR -name 'backup_complet_*' -type f -mtime +180 -exec rm -f {} \;

echo "### Backup cleanup completed : $(date "+%A %d %B %Y at %r")"
echo ""