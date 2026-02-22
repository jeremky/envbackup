# envbackup.sh

Sauvegarde les fichiers de configuration d'environnement présents dans votre
dossier home. Cette nouvelle version s'adapte à la distribution utilisée.
La liste des fichiers à sauvegarder peut être modifiée dans le fichier `.cfg`
présent dans le dossier `config`.
Son nom dépend de l'OS utilisé (debian, ubuntu...)

## Utilisation

- Créer un fichier `config/<votre_os>.cfg` et ajouter les fichiers/dossiers
    de votre dossier `home` à sauveggarder

- Exécuter le script sans paramètre sauvegarde les fichiers listés dans
    `config/<votre_os>.cfg`

- Avec le paramètre `r`, le script restaure les fichiers depuis le dossier
    `dotfiles/<votre_os>`, en écrasant les versions existantes

```bash
./envbackup.sh        # pour sauvegarder
./envbackup.sh r      # pour restaurer
```
