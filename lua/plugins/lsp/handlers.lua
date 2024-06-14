local icons = require('plugins.ui.icons.icons')
local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require('cmp_nvim_lsp')
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
    { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
    { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
  }

  vim.cmd([[
  highlight DiagnosticSignError guifg=#ea7676
  highlight DiagnosticSignWarn guifg=#eac276
  highlight DiagnosticSignHint guifg=#017bcd
  highlight DiagnosticSignInfo guifg=#017bcd
  ]])

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    virtual_lines = true,
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      -- border = { '▄', '▄', '▄', '█', '▀', '▀', '▀', '█' },
      source = 'if_many', -- Or "always"
      header = '',
      prefix = '',
      -- width = 40,
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
    -- width = 60,
    -- height = 30,
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
    -- width = 60,
    -- height = 30,
  })
end

M.on_attach = function(client, bufnr)
  if client.name == 'jdtls' then
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
  end
  client.server_capabilities.document_formatting = true
  if client.server_capabilities['documentSymbolProvider'] then
    require('nvim-navic').attach(client, bufnr)
  end
end

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

return M
