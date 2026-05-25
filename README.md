# envbackup

Sauvegarde les fichiers de configuration d'environnement de votre utilisateur.

## Utilisation

1. Récupérez le nom exact de votre distribution. Pour cela, exécutez la commande suivante dans votre terminal :

   ```bash
   grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"'
   ```

2. Créez un fichier `config/<votre_os>.cfg` et ajoutez les fichiers/dossiers de votre dossier `home` à sauvegarder (chemins relatifs à votre dossier `home`, un par ligne)

3. Exécutez le script :

   ```bash
   ./envbackup.sh        # pour sauvegarder
   ./envbackup.sh r      # pour restaurer
   ```

> Avec le paramètre `r`, le script restaure les fichiers depuis le dossier `dotfiles/<votre_os>`.
> Attention, cela va écraser les fichiers s'ils sont présents
