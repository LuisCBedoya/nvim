require('mason').setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
  max_concurrent_installers = 4,
  -- Herramientas (formatters/linters) que se instalan solas al clonar el repo.
  -- Los servidores LSP se manejan aparte en core/lsp.lua (mason-lspconfig).
  ensure_installed = {
    -- Formatters
    'stylua',
    'prettier',
    'taplo',
    'shfmt',
    -- Linters
    'stylelint',
    'htmlhint',
    'markdownlint-cli2',
    'shellcheck',
  },
})
