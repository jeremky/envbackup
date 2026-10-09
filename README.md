# envbackup

Backs up your user's environment configuration files.

## Usage

1. Get your distribution's ID. To do so, run the following command in your
   terminal:

   ```bash
   grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"'
   ```

2. Create a `config/<your_os>.cfg` file and add the files/directories from your
   `home` directory to back up (paths relative to your `home` directory, one per
   line)

3. Run the script:

   ```bash
   ./envbackup.sh        # to back up
   ./envbackup.sh r      # to restore
   ```

> The script only processes the files listed in `config/<your_os>.cfg`. With the
> `r` argument, the script restores files from `dotfiles/`. Warning: this will
> overwrite existing files

`dotfiles/` is a shared directory. A file is only backed up/restored if it is
listed in the current distribution's `config/<your_os>.cfg`.
