---- Options

-- Affichage
vim.opt.linebreak = true                       -- Revient à la ligne sans couper les mots
vim.opt.showmatch = true                       -- Afficher les parenthèses correspondantes
vim.opt.smartcase = true                       -- Faire un appariement intelligent
vim.opt.hidden = true                          -- Cacher les tampons lorsqu'ils sont abandonnés
vim.opt.list = false                           -- Désactive les caractères cachés
vim.opt.cole = 0                               -- Désactive le masquage de certains codes
vim.opt.wrap = true                            -- Active le retour à la ligne
vim.opt.relativenumber = false                 -- Utilise des numéros de line absolus
vim.opt.listchars = { eol = "$", space = "·" } -- Désactivation des caractères invisibles

-- Indentation
vim.opt.smartindent = true -- Indentation intelligente
vim.opt.tabstop = 2        -- La largeur d'une tabulation est définie sur 2
vim.opt.shiftwidth = 2     -- Les retraits auront une largeur de 2
vim.opt.softtabstop = 2    -- Nombre de colonnes pour une tabulation
vim.opt.expandtab = true   -- Remplace les tab par des espaces

-- Système
vim.opt.ignorecase = true          -- Ignorer la casse
vim.opt.mouse = ""                 -- Désactive la souris par défaut
vim.opt.backup = false             -- Désactive les sauvegardes automatiques
vim.opt.spelllang = { "en", "fr" } -- Spécifie les langues du dictionnaire

-- Configuration pour tmux
if vim.env.TERM == "tmux-256color" then
  vim.opt.mouse = "a"
end
