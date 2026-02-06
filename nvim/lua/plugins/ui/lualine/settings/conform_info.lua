-- ~/.config/nvim/lua/plugins/ui/lualine/settings/conform_info.lua
local M = {}

M.list_registered = function(filetype)
  local ok, conform = pcall(require, 'conform')
  if not ok then
    return {}
  end

  local all_formatters = conform.list_formatters(0) or {}
  local formatters_for_ft = {}

  -- Obtener formateadores configurados para este filetype
  local formatters_by_ft = conform.formatters_by_ft or {}
  local ft_formatters = formatters_by_ft[filetype] or {}

  for _, fmt_name in ipairs(ft_formatters) do
    -- Verificar si está disponible
    for _, formatter in ipairs(all_formatters) do
      if formatter.name == fmt_name and formatter.available then
        table.insert(formatters_for_ft, fmt_name)
        break
      end
    end
  end

  return formatters_for_ft
end

M.list_registered_all = function()
  local ok, conform = pcall(require, 'conform')
  if not ok then
    return {}
  end

  local all_formatters = conform.list_formatters(0) or {}
  local available = {}

  for _, formatter in ipairs(all_formatters) do
    if formatter.available then
      table.insert(available, formatter.name)
    end
  end

  return available
end

return M
