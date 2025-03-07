require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {'bashls', 'lua_ls', 'vimls', 'yamlls' }
})
