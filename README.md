# envbackup.sh

Sauvegarde les fichiers de configuration d'environnement de votre utilisateur.

## Utilisation

- Récupérez le nom exact de votre distribution. Pour cela, exécutez la commande suivante dans votre terminal :

```bash
grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"'
```

- Créez un fichier `config/<votre_os>.config` et ajoutez les fichiers/dossiers de votre dossier `home` à sauvegarder (chemins relatifs à votre dossier `home`, un par ligne)

- Exécutez le script sans paramètre pour sauvegarder les fichiers listés dans `config/<votre_os>.config`

- Avec le paramètre `r`, le script restaure les fichiers depuis le dossier `dotfiles/<votre_os>`. Attention, cela va écraser les fichiers s'ils sont présents

```bash
./envbackup.sh        # pour sauvegarder
./envbackup.sh r      # pour restaurer
```
