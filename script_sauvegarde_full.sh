#!/bin/bash

# Variables
SOURCE_DIR="/chemin/vers/R1"
DEST_DIR="/chemin/vers/sauvegardes"

BACKUP_SERVER_USER="utilisateur_s2"
BACKUP_SERVER_IP="adresse_ip_s2"
BACKUP_NAME="backup_complet_$(date +%A-%d-%B-%Y).tar.gz"

# Create archive
tar -czf "$BACKUP_NAME" $SOURCE_DIR

# Transfert to backup server
scp "$BACKUP_NAME" "$BACKUP_SERVER_USER@$BACKUP_SERVER_IP:$DEST_DIR"

# Clean local backup
rm -f "$BACKUP_NAME"

echo "Sauvegarde complète terminée : $BACKUP_NAME"
