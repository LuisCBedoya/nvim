local M = {}

-- Función para mostrar capacidades de clientes LSP activos
M.server_capabilities = function()
  local active_clients = vim.lsp.get_active_clients()
  local active_client_map = {}

  for index, value in ipairs(active_clients) do
    active_client_map[value.name] = index
  end

  vim.ui.select(vim.tbl_keys(active_client_map), {
    prompt = 'Select client:',
    format_item = function(item)
      return 'capabilities for: ' .. item
    end,
  }, function(choice)
    if choice then
      local client = vim.lsp.get_active_clients()[active_client_map[choice]]
      print(vim.inspect(client.server_capabilities.executeCommandProvider))
      vim.pretty_print(client.server_capabilities)
    end
  end)
end

require('plugins.core.mason') -- 1. Instala herramientas
require('plugins.core.handlers').setup() -- 2. Configura LSP
require('plugins.core.cmp') -- 3. Autocompletado
require('plugins.core.conform') -- 4. Formateadores
require('plugins.core.nvim-lint') -- 5. Linters
require('plugins.core.lsp') -- 6. Servidores LSP

return M
