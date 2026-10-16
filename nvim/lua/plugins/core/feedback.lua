-- Feedback e instrucciones para formatear / lintear / ver el estado del IDE.
local M = {}

-- Herramienta sugerida por filetype (para las instrucciones)
local suggestions = {
  lua = { fmt = 'stylua' },
  html = { fmt = 'prettier', lint = 'htmlhint' },
  css = { fmt = 'prettier', lint = 'stylelint' },
  scss = { fmt = 'prettier', lint = 'stylelint' },
  less = { fmt = 'prettier', lint = 'stylelint' },
  javascript = { fmt = 'prettier', lint = 'eslint' },
  javascriptreact = { fmt = 'prettier', lint = 'eslint' },
  typescript = { fmt = 'prettier', lint = 'eslint' },
  typescriptreact = { fmt = 'prettier', lint = 'eslint' },
  json = { fmt = 'prettier' },
  jsonc = { fmt = 'prettier' },
  yaml = { fmt = 'prettier' },
  markdown = { fmt = 'prettier', lint = 'markdownlint-cli2' },
  sh = { fmt = 'shfmt', lint = 'shellcheck' },
  bash = { fmt = 'shfmt', lint = 'shellcheck' },
}

local function ft_name()
  local ft = vim.bo.filetype
  return ft ~= '' and ft or 'text'
end

---¿Está instalado el linter? nvim-lint define `cmd` como string, tabla o función.
---@param linter table|nil
---@param name string
---@return boolean
function M.linter_installed(linter, name)
  local cmd = (linter and linter.cmd) or name
  if type(cmd) == 'function' then
    local ok, res = pcall(cmd)
    cmd = ok and res or name
  end
  if type(cmd) == 'table' then
    cmd = cmd[1]
  end
  return type(cmd) == 'string' and vim.fn.executable(cmd) == 1
end

---Avisa que falta configurar/instalar un formatter o linter, con instrucciones.
---@param kind 'formatter'|'linter'
local function notify_missing(kind)
  local ft = ft_name()
  local s = suggestions[ft] or {}
  local tool = kind == 'formatter' and s.fmt or s.lint
  local edit_file = kind == 'formatter' and 'lua/plugins/core/conform.lua (formatters_by_ft)'
    or 'lua/plugins/core/nvim-lint.lua (linters_by_ft)'

  local lines = { string.format('Sin %s para "%s".', kind, ft) }
  if tool then
    table.insert(lines, '→ Instalá:  :MasonInstall ' .. tool)
  end
  table.insert(lines, '→ O editá:  ' .. edit_file)
  vim.notify(table.concat(lines, '\n'), vim.log.levels.WARN)
end

---Formatea el buffer actual con feedback.
function M.format()
  local ok, conform = pcall(require, 'conform')
  if not ok then
    return
  end

  local available = {}
  for _, f in ipairs(conform.list_formatters(0)) do
    if f.available then
      table.insert(available, f.name)
    end
  end

  local has_lsp_formatter = false
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if c:supports_method('textDocument/formatting') then
      has_lsp_formatter = true
      break
    end
  end

  if #available == 0 and not has_lsp_formatter then
    notify_missing('formatter')
    return
  end

  conform.format({ async = true, lsp_format = 'fallback' }, function(err, did_edit)
    if err then
      vim.notify('Error al formatear: ' .. tostring(err), vim.log.levels.ERROR)
    elseif did_edit then
      local who = #available > 0 and table.concat(available, ', ') or 'LSP'
      vim.notify('Formateado con ' .. who, vim.log.levels.INFO)
    else
      vim.notify('Sin cambios al formatear', vim.log.levels.INFO)
    end
  end)
end

---Lintea el buffer actual con feedback.
function M.lint()
  local ok, lint = pcall(require, 'lint')
  if not ok then
    return
  end

  local ft = vim.bo.filetype
  local names = lint.linters_by_ft[ft] or {}

  local installed = {}
  for _, name in ipairs(names) do
    if M.linter_installed(lint.linters[name], name) then
      table.insert(installed, name)
    end
  end

  if #installed == 0 then
    notify_missing('linter')
    return
  end

  lint.try_lint()
  vim.notify('Linteando con ' .. table.concat(installed, ', '), vim.log.levels.INFO)
end

---Muestra el estado (LSP / formatter / linter) del buffer actual.
function M.status()
  local ft = ft_name()
  local lines = { string.format('IDE — %s  (%s)', ft, vim.fn.expand('%:t')) }

  -- LSP
  local lsp = {}
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(lsp, c.name)
  end
  table.insert(
    lines,
    (lsp[1] and '󰦕 LSP: ' or '󱄊 LSP: ') .. (lsp[1] and table.concat(lsp, ', ') or 'no activo')
  )

  -- Formatters
  local conform_ok, conform = pcall(require, 'conform')
  if conform_ok then
    local avail = {}
    for _, f in ipairs(conform.list_formatters(0)) do
      if f.available then
        table.insert(avail, f.name)
      end
    end
    table.insert(
      lines,
      (avail[1] and '󰦕 Formatter: ' or '󱄊 Formatter: ')
        .. (avail[1] and table.concat(avail, ', ') or 'no configurado/instalado')
    )
  end

  -- Linters
  local lint_ok, lint = pcall(require, 'lint')
  if lint_ok then
    local names = lint.linters_by_ft[ft] or {}
    local avail = {}
    for _, name in ipairs(names) do
      if M.linter_installed(lint.linters[name], name) then
        table.insert(avail, name)
      end
    end
    table.insert(
      lines,
      (avail[1] and '󰦕 Linter: ' or '󱄊 Linter: ')
        .. (avail[1] and table.concat(avail, ', ') or 'no configurado/instalado')
    )
  end

  vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
end

return M
