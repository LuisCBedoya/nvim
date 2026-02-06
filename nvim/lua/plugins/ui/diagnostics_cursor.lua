local icons = require('plugins.ui.icons.icons')
local M = {}

local ns = vim.api.nvim_create_namespace('CursorDiagnostics')

function M.setup(opts)
  opts = opts or {}
  opts.show_gutter = opts.show_gutter or false

  -- 1. Configuración GLOBAL de signos (para show_gutter = true)
  vim.diagnostic.config({
    virtual_text = false,
    signs = opts.show_gutter, -- true = signs siempre visibles, false = ocultos globalmente
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded' },
  })

  -- Define los iconos GLOBALES (solo necesarios si show_gutter = true)
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

  -- 2. Función para mostrar signos LOCALES (solo en línea actual)
  local function update_cursor_diagnostic()
    local buf = vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end

    vim.diagnostic.hide(ns, buf) -- Oculta diagnósticos previos

    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local line_diags = vim.diagnostic.get(buf, { lnum = lnum })
    if vim.tbl_isempty(line_diags) then
      return
    end

    -- Solo aplica signos locales si show_gutter = false
    local config = {
      virtual_text = {
        prefix = '',
        spacing = 4,
        format = function(d)
          return d.message
        end,
      },
      underline = false,
      signs = not opts.show_gutter
          and { -- Signs locales solo si show_gutter = false
            text = {
              [vim.diagnostic.severity.ERROR] = icons.diagnostics.square,
              [vim.diagnostic.severity.WARN] = icons.diagnostics.square,
              [vim.diagnostic.severity.INFO] = icons.diagnostics.square,
              [vim.diagnostic.severity.HINT] = icons.diagnostics.square,
            },
          }
          or false,
    }

    vim.diagnostic.show(ns, buf, line_diags, config)
  end

  -- 3. Autocomandos para actualizar diagnósticos
  local group = vim.api.nvim_create_augroup('CursorDiagnosticsGroup', { clear = true })
  vim.api.nvim_create_autocmd({
    'CursorMoved',
    'CursorMovedI',
    'DiagnosticChanged',
    'InsertLeave',
    'BufEnter',
    'BufWinEnter',
  }, {
    group = group,
    callback = update_cursor_diagnostic,
  })
end

return M
