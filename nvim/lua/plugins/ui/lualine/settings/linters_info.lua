-- Actualizado para nvim-lint
local M = {}

M.linter_list_registered = function(filetype)
  local ok, lint = pcall(require, 'lint')
  if not ok then
    return {}
  end

  local linters_by_ft = lint.linters_by_ft or {}
  local linters = linters_by_ft[filetype] or {}

  -- Eliminar duplicados
  local unique = {}
  for _, linter in ipairs(linters) do
    unique[linter] = true
  end

  return vim.tbl_keys(unique)
end

return M
