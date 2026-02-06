local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- VARIABLES DE VISIBILIDAD
local bufferline_visible = true
local lualine_visible = true

-- =========================
-- NATIVE
-- =========================
keymap('v', '<leader>y', '"+y', opts)
keymap('n', '<C-s>', '<cmd>w<CR>', opts)
keymap('n', '<leader>x', '<cmd>bd<CR>', fopts)
vim.keymap.set('n', '<leader>q', function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs > 1 then
    vim.cmd('bdelete')
  else
    vim.cmd('quit')
  end
end)
keymap('n', '<leader>Q', '<cmd>w<CR><cmd>q<CR>')
keymap('i', 'jk', '<ESC>', opts)

-- keymap('n', '<C-u>', '{', opts) -- Ctrl+u = Subir párrafo
-- keymap('n', '<C-d>', '}', opts) -- Ctrl+d = Bajar párrafo

keymap('i', '<A-BS>', '<C-w>')
keymap('i', '<C-BS>', '<C-w>')

keymap('n', '<leader>j', 'J', opts)
keymap('v', '<leader>j', 'J', opts)

keymap('n', '<A-0>', 'd$', opts)
keymap('n', 'v', 'V', opts)

-- Identado
keymap('v', 'ñ', '<gv', opts)
keymap('v', '<leader>ñ', '>gv', opts)
keymap('n', '<leader>ñ', '>>', opts)
keymap('n', 'ñ', '<<', opts)

-- saltar entre llaves y corchetes
keymap('n', 't', '%', opts)
keymap('v', 't', '%', opts)

-- Numeros relativos
keymap('n', '<leader>tn', '<cmd>set nu!<CR>', { desc = 'Alternar números de línea' })
keymap('n', '<leader>tr', '<cmd>set rnu!<CR>', { desc = 'Alternar números relativos' })
-- =========================
-- UI: BUFFERLINE
-- =========================
-- keymap('n', '<A-p>', ':BufferLineTogglePin<CR>', { desc = '(bufferL) Pin Pestaña' })
keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', opts)
keymap('n', '<leader>tb', function()
  bufferline_visible = not bufferline_visible
  if bufferline_visible then
    vim.o.showtabline = 2
  else
    vim.o.showtabline = 0
  end
end, { desc = 'Toggle Bufferline' })

-- =========================
-- UI: LUALINE
-- =========================
keymap('n', '<leader>tl', function()
  lualine_visible = not lualine_visible
  if lualine_visible then
    require('lualine').hide({ unhide = true })
  else
    require('lualine').hide()
  end
end, { desc = 'Toggle Lualine' })

-- =========================
-- UI: TREE
-- =========================
keymap('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')

-- =========================
-- UI: TELESCOPE
-- =========================
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Buscar Archivos' })
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Buscar Coincidencias' })
keymap('n', '<leader>fm', ':TodoTelescope<CR>', { desc = 'Buscar Todos-Comments' })
keymap('n', '<leader>fn', '<Cmd>Telescope notify<CR>', { desc = 'Buscar Notificaciones' })

-- =========================
-- UI: SMEAR-CURSOR
-- =========================

keymap('n', '<leader>ts', '<cmd>SmearCursorToggle<CR>', {
  desc = 'Toggle smear cursor',
  silent = true,
})

-- =========================
-- TOOLS: Panel-Resize
-- =========================
keymap('n', '<leader>tp', '<cmd>PaneResizerToggle<CR>', {
  desc = 'Toggle Pane Resizer',
})
-- =========================
-- TOOLS: COMMENTS
-- =========================
keymap('n', '<leader>cl', 'gcc', { remap = true })
keymap('v', '<leader>c', 'gc', { remap = true })

-- =========================
-- TOOLS: MOVE
-- =========================
keymap('n', '<A-j>', ':MoveLine(1)<CR>', { desc = '(move) Mover Línea Abajo', remap = true })
keymap('n', '<A-k>', ':MoveLine(-1)<CR>', { desc = '(move) Mover Línea Arriba', remap = true })
keymap('v', '<A-j>', ':MoveBlock(1)<CR>', { desc = '(move) Mover Bloque Abajo', remap = true })
keymap('v', '<A-k>', ':MoveBlock(-1)<CR>', { desc = '(move) Mover Bloque Arriba', remap = true })

-- =========================
-- TOOLS: SNIP
-- =========================
keymap(
  'n',
  '<S-u>',
  ':lua require("snipe").open_buffer_menu()<CR>',
  { desc = '(snipe) Abrir menú de buffer', silent = true }
)

-- =========================
-- TOOLS: conform
-- =========================
keymap({ 'n', 'v' }, '<leader>af', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
  vim.notify('Formateado')
end, { desc = 'Formatear buffer' })

-- =========================
-- TOOLS: nvim-lint
-- =========================
keymap('n', '<leader>al', function()
  require('lint').try_lint()
  vim.notify('Linteando')
end, { desc = 'Lintear buffer actual' })
