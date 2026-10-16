local servers = {
  'lua_ls',
  'ts_ls',
  'emmet_ls',
  'html',
  'cssls',
  'jsonls',
  'yamlls',
  'bashls',
  'marksman',
}

-- Config por servidor (claves de nivel superior: settings, filetypes, init_options, ...)
local server_config = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = { enable = false },
      },
    },
  },

  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  emmet_ls = {
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
      html = {
        options = {
          -- configuraciones específicas de Emmet
        },
      },
    },
  },
}

-- Instala los servidores vía mason (solo instalación; habilitamos a mano abajo)
require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_enable = false,
})

local handlers = require('plugins.core.handlers')

-- Configura y habilita cada servidor con el API nativo de Neovim 0.11+
for _, server_name in ipairs(servers) do
  vim.lsp.config(
    server_name,
    vim.tbl_deep_extend('force', {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
    }, server_config[server_name] or {})
  )
  vim.lsp.enable(server_name)
end
