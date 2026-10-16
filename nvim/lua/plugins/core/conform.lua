local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    toml = { 'taplo' },
    -- Prettier (Mason)
    html = { 'prettierd', 'prettier' },
    css = { 'prettierd', 'prettier' },
    scss = { 'prettierd', 'prettier' },
    less = { 'prettierd', 'prettier' },
    javascript = { 'prettierd', 'prettier' },
    javascriptreact = { 'prettierd', 'prettier' },
    typescript = { 'prettierd', 'prettier' },
    typescriptreact = { 'prettierd', 'prettier' },
    json = { 'prettierd', 'prettier' },
    jsonc = { 'prettierd', 'prettier' },
    yaml = { 'prettierd', 'prettier' },
    markdown = { 'prettierd', 'prettier' },
    graphql = { 'prettierd', 'prettier' },
    -- Shell
    sh = { 'shfmt' },
    bash = { 'shfmt' },
  },

  formatters = {
    stylua = {
      prepend_args = {
        '--indent-type',
        'Spaces',
        '--indent-width',
        '2',
        '--column-width',
        '120',
        '--line-endings',
        'Unix',
        '--quote-style',
        'AutoPreferSingle',
        '--call-parentheses',
        'Always',
        '--collapse-simple-statement',
        'Never',
      },
    },
  },

  -- Formatear al guardar
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },

  -- Avisos
  notify_on_error = true,
  notify_no_formatters = true,
  log_level = vim.log.levels.WARN,
})
