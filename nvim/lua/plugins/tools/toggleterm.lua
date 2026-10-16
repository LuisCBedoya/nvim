-- Terminal con toggleterm.nvim
require('toggleterm').setup({
  -- Tamaño según la dirección
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return math.floor(vim.o.columns * 0.4)
    end
    return 20
  end,

  open_mapping = [[<F12>]], -- toggle global (normal/insert/terminal)
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'float',
  close_on_exit = true,
  shell = vim.o.shell,

  float_opts = {
    border = 'curved',
    winblend = 0,
  },
})

-- Salir del modo terminal con <Esc><Esc>
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('UserTerminal', { clear = true }),
  callback = function(args)
    vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], {
      buffer = args.buf,
      desc = 'Salir de terminal',
    })
  end,
})

return {}
