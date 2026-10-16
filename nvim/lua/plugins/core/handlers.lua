local M = {}

-- ====================== CAPABILITIES ======================
M.capabilities = require('cmp_nvim_lsp').default_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
-- Forzar diagnósticos "push" (publishDiagnostics) en todos los servidores:
-- ts_ls y vscode-html/css/json dejan de reportar en vivo si el cliente
-- anuncia soporte de "pull" (textDocument.diagnostic).
M.capabilities.textDocument.diagnostic = nil

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

  vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
    config = config or {}
    config.border = 'rounded'
    vim.lsp.handlers.hover(_, result, ctx, config)
  end

  vim.lsp.handlers['textDocument/signatureHelp'] = function(_, result, ctx, config)
    config = config or {}
    config.border = 'rounded'
    vim.lsp.handlers.signature_help(_, result, ctx, config)
  end
end

-- ====================== ON ATTACH ======================
-- Los keymaps de LSP están centralizados en lua/config/keymaps.lua
-- (se aplican con un autocmd LspAttach).
M.on_attach = function(client, bufnr)
  -- Reservado para lógica por-cliente si se necesita
end

require('plugins.ui.diagnostics_cursor').setup({
  show_gutter = true, -- false - mostrar icons cuando estoy en la linea / true para mostrar siempre los iconos
})
return M
