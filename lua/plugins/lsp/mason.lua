--angular
-- local project_library_path = '$HOME/.config/nvm/versions/node/v20.11.1/lib/node_modules'
-- local cmd = {
--   'node',
--   '$HOME/.config/nvm/versions/node/v20.11.1/lib/node_modules/@angular/language-server',
--   '--stdio',
--   '--tsProbeLocations',
--   project_library_path,
--   '--ngProbeLocations',
--   project_library_path,
-- }

local servers = {
  'tsserver', -- js
  'emmet_ls', -- html
  'lua_ls', -- lua
  'cssls', --css
  'marksman', -- markdown
  'angularls', --angular
  'jdtls', -- java
}
-- **** DEBUGGERS
local debuggers = {
  'debugpy', -- python
  'java-debug-adapter', -- java
  'java-test',
}
-- **** FORMATTERS
local null_ls = {
  'stylua', -- lua
  'prettier', -- html, css , js, etc
  'jq', -- json
}

local settings = {
  ui = {
    -- border = 'rounded',
    icons = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
}

require('mason').setup(settings)
require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_installation = false,
})

require('mason-nvim-dap').setup({
  ensure_installed = debuggers,
  automatic_installation = false,
})

require('mason-null-ls').setup({
  ensure_installed = null_ls,
  automatic_installation = false,
})

local lspconfig = require('lspconfig')
local opts = {}
local settings = {
  Lua = {
    diagnostics = {
      globals = { 'vim' },
    },
  },
}

for _, server in pairs(servers) do
  opts = {
    on_attach = require('plugins.lsp.handlers').on_attach,
    capabilities = require('plugins.lsp.handlers').capabilities,
  }

  if server == 'jdtls' then
    goto continue
  end

  if server == 'lua_ls' then
    opts.settings = settings
  end

  -- if server == 'angularls' then
  --   opts.on_new_config = function(new_config, new_root_dir)
  --     new_config.cmd = cmd
  --   end
  -- end

  lspconfig[server].setup(opts)
  ::continue::
end
