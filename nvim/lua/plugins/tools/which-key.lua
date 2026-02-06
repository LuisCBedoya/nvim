local wk = require('which-key')
wk.setup({
  diagnostics = {
    warn = false,
  },

  icons = {
    mappings = false,
  },

  win = {
    border = 'rounded',
    padding = { 2, 2, 2, 2 },
  },

  keys = {
    scroll_down = '<c-d>',
    scroll_up = '<c-u>',
  },
  triggers = {
    { '<leader>', mode = { 'n', 'v' } },
  },

  filter = function(mapping)
    return mapping.desc and mapping.desc ~= ''
  end,
})

wk.add({
  { '<leader>f', group = 'Telescope' },
  { '<leader>t', group = 'Toggles' },
  { '<leader>a', group = 'Config' },
  { '<leader>l', group = 'Lualine' },
})
