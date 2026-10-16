-- Linters
local lint = require('lint')

lint.linters_by_ft = {
  javascript = { 'eslint' },
  javascriptreact = { 'eslint' },
  typescript = { 'eslint' },
  typescriptreact = { 'eslint' },
  css = { 'stylelint' },
  scss = { 'stylelint' },
  html = { 'htmlhint' },
  markdown = { 'markdownlint-cli2' },
  sh = { 'shellcheck' },
  bash = { 'shellcheck' },
  -- yaml: sin linter (yamllint requiere pip, no disponible en este sistema)
}

local function try_lint()
  pcall(function()
    require('lint').try_lint()
  end)
end

-- Lintear al guardar (siempre)
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = try_lint,
})

-- Lintear en vivo (debounce 300ms) al editar:
-- cubre htmlhint (HTML), ya que html-lsp no valida la estructura de tags
local live_group = vim.api.nvim_create_augroup('LintLive', { clear = true })
local lint_timer
vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
  group = live_group,
  callback = function()
    if lint_timer then
      lint_timer:stop()
      lint_timer:close()
    end
    lint_timer = vim.defer_fn(function()
      lint_timer = nil
      try_lint()
    end, 300)
  end,
})

return {}
