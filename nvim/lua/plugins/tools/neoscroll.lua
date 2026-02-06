local neoscroll = require('neoscroll')

neoscroll.setup({
  easing_function = 'quadratic',
  hide_cursor = true,
  stop_eof = true,
})

local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

-- Scroll medio buffer
keymap('n', '<C-u>', function()
  neoscroll.ctrl_u({ duration = 120 })
end, opts)

keymap('n', '<C-d>', function()
  neoscroll.ctrl_d({ duration = 120 })
end, opts)

-- Scroll página completa
keymap('n', '<C-b>', function()
  neoscroll.ctrl_b({ duration = 200 })
end, opts)

keymap('n', '<C-f>', function()
  neoscroll.ctrl_f({ duration = 200 })
end, opts)

-- Scroll fino
keymap('n', '<C-y>', function()
  neoscroll.scroll(-0.1, { move_cursor = false, duration = 80 })
end, opts)

keymap('n', '<C-e>', function()
  neoscroll.scroll(0.1, { move_cursor = false, duration = 80 })
end, opts)

