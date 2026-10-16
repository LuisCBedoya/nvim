local icons = require('plugins.ui.icons.icons')
local M = {}

function M.setup(opts)
  opts = opts or {}
  opts.show_gutter = opts.show_gutter or false

  vim.diagnostic.config({
    -- Texto inline del error en TODAS las líneas afectadas (visible al instante)
    virtual_text = {
      prefix = '',
      spacing = 4,
    },
    signs = opts.show_gutter, -- true = iconos en el gutter siempre visibles
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = { border = 'rounded' },
  })

  -- Define los iconos del gutter
  if opts.show_gutter then
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.square,
          [vim.diagnostic.severity.WARN] = icons.diagnostics.square,
          [vim.diagnostic.severity.INFO] = icons.diagnostics.square,
          [vim.diagnostic.severity.HINT] = icons.diagnostics.square,
        },
      },
    })
  end
end

return M
