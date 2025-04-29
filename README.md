# envbackup.sh

Sauvegarde les fichiers de configuration d'environnement présents dans votre dossier home. La liste des fichiers à sauvegarder peut être modifiée dans le fichier `envbackup.lst`.

## Utilisation

- Exécuter le script sans paramètre sauvegarde les fichiers listés dans `envbackup.lst`

- Avec le paramètre `r`, ou si `.bash_aliases` est absent, le script restaure les fichiers depuis le dossier `dotfiles`, en écrasant les versions existantes

```bash
./envbackup.sh        # pour sauvegarder
./envbackup.sh r      # pour restaurer
```
