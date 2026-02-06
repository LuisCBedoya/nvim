-- Linters
local lint = require('lint')

lint.linters_by_ft = {
  lua = { 'selene' },
}
-- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
--   callback = function()
--     -- Ejecutar silenciosamente
--     pcall(function()
--       require('lint').try_lint()
--     end)
--   end,
-- })

return {}
