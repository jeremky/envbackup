# envbackup.sh

Sauvegarde les fichiers de configuration d'environnement présents dans votre dossier home.
Cette nouvelle version s'adapte à la distribution utilisée.
La liste des fichiers à sauvegarder peut être modifiée dans le fichier `.config` présent dans le dossier `config`.
Son nom dépend de l'OS utilisé (debian, ubuntu...)

## Utilisation

- Créer un fichier `config/<votre_os>.config` et ajouter les fichiers/dossiers de votre dossier `home` à sauvegarder

- Exécuter le script sans paramètre sauvegarde les fichiers listés dans `config/<votre_os>.config`

- Avec le paramètre `r`, le script restaure les fichiers depuis le dossier `dotfiles/<votre_os>`, en écrasant les versions existantes

```bash
./envbackup.sh        # pour sauvegarder
./envbackup.sh r      # pour restaurer
```

## Installation

Il est possible de créer un lien symbolique pour vous permettre d'appeler la commande `envbackup` de n'importe où. Pour cela :

```bash
make install
```
