-- disable netrw at the very start of your init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 400,
  },
  renderer = {
    group_empty = true,
    --    icons = {
      --      show = {
        --        file = false,
        --        folder = false,
        --        folder_arrow = false,
        --        git = false,
        --      },
        --    },
      },
      filters = {
        dotfiles = false,
      },
    })

-- Ouvrir NvimTree automatiquement si aucun fichier n'est ouvert
vim.cmd([[
  augroup OpenNvimTree
    autocmd!
    autocmd VimEnter * if !argc() | NvimTreeToggle | endif
  augroup END
]])
