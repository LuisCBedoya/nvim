local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    yaml = { 'prettierd', 'prettier' },
    toml = { 'taplo' },
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

  -- format_on_save = false,

  -- Opcional: Notificaciones
  notify_on_error = true,
  log_level = vim.log.levels.WARN,
})
