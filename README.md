# Mise en place de sauvegardes automatisées

Par **NGOUANFO MANFO**

## Énoncé

**Objectif:** Automatiser la sauvegarde d’un répertoire `R1` situé sur le serveur `S1` vers un répertoire `R2` situé sur le serveur distant `S2`, une gestion des anciennes sauvegardes pour éviter une surcharge de stockage.

**Outils :** `scp`, `rsync`

1. Écrire un script Bash (`script_sauvegarde_full.sh`) qui permet de réaliser une sauvegarde complète de R1.

2. Écrire un script Bash (`script_sauvegarde_diff.sh`) qui permet  de réaliser des sauvegardes différentielles tous les jours, du lundi au samedi.

3. Écrire un script Bash  (`script_nettoyage_backup.sh`) qui permet  de supprimer:

    - Les sauvegardes différentielles âgées de plus de 7 jours.
    - Les sauvegardes hebdomadaires (complètes du dimanche) âgées de plus de 4 semaines.
    - Les sauvegardes mensuelles âgées de plus de 6 mois.

4. Donner les lignes à ajouter au fichier crontab pour automatiser les tâches:
    - Sauvegardes différentielles du lundi à samedi.
    - Sauvegarde complète hebdomadaire le dimanche.
    - Sauvegarde complète mensuelle le premier jour de chaque mois.
    - Nettoyage des anciennes sauvegardes

5. Justifier le choix des heures que vous avez choisies pour vos jobs.

## Fonctionnement

- Les scripts `script_sauvegarde_full.sh` et `script_sauvegarde_diff.sh` seront déployés sur le serveur `S1`.

- Le script `script_nettoyage_backup.sh` sera déployé sur le serveur de sauvegarde `S2`.

### Configuration du Fichier `cron`

```bash
# Sauvegardes différentielles du lundi au samedi à 
0 2 * * 1-6 /chemin/vers/script_sauvegarde_diff.sh >> /var/log/script_sauvegarde_diff.log 2>&1

# Sauvegarde complète le dimanche
0 2 * * 7 /chemin/vers/script_sauvegarde_full.sh >> /var/log/script_sauvegarde_full.log 2>&1

# Sauvegarde complète mensuelle le premier jour de chaque mois
0 2 1 * * /chemin/vers/script_sauvegarde_full.sh >> /var/log/script_sauvegarde_full.log 2>&1

# Nettoyage des anciennes sauvegardes (chaque dimanche à 3h)
0 3 * * 7 /chemin/vers/script_nettoyage_backup.sh >> /var/log/script_nettoyage_backup.log 2>&1
```