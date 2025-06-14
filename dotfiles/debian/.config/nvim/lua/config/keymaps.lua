---- Keymaps

-- Numéros de ligne
vim.api.nvim_set_keymap("n", "<F2>", ":set number!<CR>", { noremap = true, silent = true })

-- Correction orthographique
vim.api.nvim_set_keymap("n", "<F3>", ":set spell!<CR>", { noremap = true, silent = true })

-- Affichage des caractères invisibles
vim.api.nvim_set_keymap("n", "<F4>", ":set list!<CR>", { noremap = true, silent = true })

-- Indentation automatique
vim.api.nvim_set_keymap("n", "<F5>", "gg=G<CR>", { noremap = true, silent = true })

-- Souris
vim.api.nvim_set_keymap("n", "<F6>", ":call ToggleMouse()<CR>", { noremap = true, silent = true })
vim.cmd([[
function! ToggleMouse()
if &mouse == 'a'
set mouse=
echo "Souris désactivée"
else
set mouse=a
echo "Souris activée"
endif
endfunction
]])

-- Changement de document
vim.api.nvim_set_keymap("n", "<S-TAB>", "<C-W>w", { noremap = true, silent = true })
