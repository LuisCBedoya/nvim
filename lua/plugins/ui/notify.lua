local icons = require('plugins.ui.icons.icons')

vim.notify = require('notify')

require('notify').setup({
  stages = 'static',
  on_open = nil,
  on_close = nil,
  render = 'default',
  timeout = 5000,
  background_colour = '#000000',
  minimum_width = 10,
  icons = {
    ERROR = icons.diagnostics.Error,
    WARN = icons.diagnostics.Warning,
    INFO = icons.diagnostics.Information,
    DEBUG = icons.ui.Bug,
    TRACE = icons.ui.Pencil,
  },
})
-- local notify_filter = vim.notify
-- vim.notify = function(msg, ...)
--   if msg:match('character_offset must be called') then
--     return
--   end
--   if msg:match('method textDocument') then
--     return
--   end

--   notify_filter(msg, ...)
-- end
vim.cmd([[
  highlight NotifyERRORBorder guifg=#ea7676
  highlight NotifyINFOBorder guifg= #017bcd
  highlight NotifyWARNBorder guifg=#eac267

  highlight NotifyERRORIcon guifg=#ea7676
  highlight NotifyINFOIcon guifg= #017bcd
  highlight NotifyWARNIcon guifg=#eac267

  highlight NotifyERRORTitle guifg=#ea7676
  highlight NotifyINFOTitle guifg= #017bcd
  highlight NotifyWARNTitle guifg=#eac267
  ]])
