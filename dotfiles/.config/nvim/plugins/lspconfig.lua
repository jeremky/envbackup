local lspconfig = require('lspconfig')

-- Ajouter les capacités LSP pour la complétion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configuration de Bash LSP
lspconfig.bashls.setup({
  capabilities = capabilities,
  filetypes = { "sh", "bash", "zsh" },
})

-- Configuration du serveur LSP pour Docker Compose
lspconfig.docker_compose_language_service.setup({
  capabilities = capabilities,
  filetypes = { "yaml", "docker-compose", "compose" },
})

-- Configuration du serveur LSP pour Markdown
lspconfig.markdown_oxide.setup({
  capabilities = capabilities,
  filetypes = { "markdown" },
})
