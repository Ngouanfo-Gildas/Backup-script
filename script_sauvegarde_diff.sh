#!/bin/bash

SOURCE_DIR="/chemin/vers/R1"
DEST_DIR="/chemin/vers/sauvegardes"
REMOTE_USER="utilisateur_s2"
REMOTE_HOST="adresse_ip_s2"
SNAPSHOT_DIR="/chemin/vers/snapshots"
DATE=$(date "+%A-%d-%B-%Y")

# Sauvegarde complète
if [[ "$DAY_OF_WEEK" -eq 7 ]] || [[ "$DAY_OF_MONTH" -eq 1 ]]; then
    BACKUP_TYPE="complet"
    BACKUP_NAME="backup_complet_$(date +%Y-%m-%d).tar.gz"
    tar -czf "$BACKUP_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"
else
    # Sauvegarde différentielle
    BACKUP_TYPE="différentiel"
    BACKUP_NAME="backup_diff_$(date +%Y-%m-%d).tar.gz"
    rsync -az --compare-dest="$SNAPSHOT_DIR" "$SOURCE_DIR" "$BACKUP_NAME"
fi

# Transfert vers le serveur distant
scp "$BACKUP_NAME" "$REMOTE_USER@$REMOTE_HOST:$DEST_DIR"

# Mise à jour du snapshot pour les sauvegardes différentielles
if [[ "$BACKUP_TYPE" == "différentiel" ]]; then
    rsync -a --delete "$SOURCE_DIR/" "$SNAPSHOT_DIR/"
fi

# Nettoyage local
rm -f "$BACKUP_NAME"

echo "Sauvegarde $BACKUP_TYPE terminée : $BACKUP_NAME"
