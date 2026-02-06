local icons = require('plugins.ui.icons.icons')
local M = {}

-- ====================== CAPABILITIES ======================
M.capabilities = require('cmp_nvim_lsp').default_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- ====================== SETUP DIAGNOSTICS ======================
M.setup = function()
  vim.cmd([[
  highlight DiagnosticVirtualTextError guifg=#ea7676 guibg=#3c1f1f
  highlight DiagnosticVirtualTextWarn  guifg=#eac276 guibg=#3c2f1f
  highlight DiagnosticVirtualTextHint  guifg=#017bcd guibg=#1f2f3c
  highlight DiagnosticVirtualTextInfo  guifg=#56b6c2 guibg=#1f2f2f

  highlight DiagnosticUnderlineError gui=undercurl guisp=#ea7676
  highlight DiagnosticUnderlineWarn  gui=undercurl guisp=#eac276
  highlight DiagnosticUnderlineHint  gui=undercurl guisp=#017bcd
  highlight DiagnosticUnderlineInfo  gui=undercurl guisp=#56b6c2

  highlight DiagnosticSignError guifg=#ea7676 guibg=NONE
  highlight DiagnosticSignWarn guifg=#eac276 guibg=NONE
  highlight DiagnosticSignHint guifg=#017bcd guibg=NONE
  highlight DiagnosticSignInfo guifg=#017bcd guibg=NONE
]])

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

-- ====================== ON ATTACH ======================
M.on_attach = function(client, bufnr)
  -- Configuración específica para jdtls
  if client.name == 'jdtls' then
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
  end

  -- Habilitar formateo del servidor
  client.server_capabilities.documentFormattingProvider = true

  -- Keymaps locales para LSP
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)

  -- Integración con nvim-navic (si está instalado)
  if pcall(require, 'nvim-navic') and client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end
end

-- ====================== FORMAT ON SAVE ======================
function M.enable_format_on_save()
  vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = true })
    augroup end
  ]])
  vim.notify('Enabled format on save')
end

function M.disable_format_on_save()
  M.remove_augroup('format_on_save')
  vim.notify('Disabled format on save')
end

function M.toggle_format_on_save()
  if vim.fn.exists('#format_on_save#BufWritePre') == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists('#' .. name) == 1 then
    vim.cmd('au! ' .. name)
  end
end

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("plugins.lsp.handlers").toggle_format_on_save()' ]])

require('plugins.ui.diagnostics_cursor').setup({
  show_gutter = true, -- false - mostrar icons cuando estoy en la linea / true para mostrar siempre los iconos
})
return M
