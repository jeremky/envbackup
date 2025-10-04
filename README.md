# envbackup.sh

Sauvegarde les fichiers de configuration d'environnement présents dans votre
dossier home. Cette nouvelle version s'adapte à la distribution utilisée.
La liste des fichiers à sauvegarder peut être modifiée dans le fichier `lst`
présent dans `config`. Son nom dépend de l'OS utilisé (debian, fedora, ubuntu...)

## Utilisation

- Exécuter le script sans paramètre sauvegarde les fichiers listés dans `config/<votre_os>.lst`

- Avec le paramètre `r`, le script restaure les fichiers depuis le dossier
`dotfiles/<votre_os>`, en écrasant les versions existantes

```bash
./envbackup.sh        # pour sauvegarder
./envbackup.sh r      # pour restaurer
```
