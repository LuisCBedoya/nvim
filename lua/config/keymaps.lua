local opts = { noremap = true, silent = true }
local fopts = { noremap = false, silent = true }
local keymap = vim.keymap.set
local is_folded = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
------------------------------------------- user keymaps -----------------------------
keymap('n', '<C-s>', '<cmd>w<CR>', opts)
keymap('n', '<leader>x', '<cmd>bd<CR>', fopts)
keymap('n', '<leader>Q', '<cmd>w<CR><cmd>q<CR>')
keymap('i', 'jk', '<ESC>', opts)
keymap('n', '<C-Space>', ':', { desc = 'modo comando' })
keymap('n', '<A-0>', 'd$', opts)
keymap('n', 'v', 'V', opts)
keymap('n', '<C-A-k>', '<cmd> resize +2<CR>')
keymap('n', '<C-A-j>', '<cmd> resize -2<CR>')
keymap('n', '<C-A-l>', '<cmd> vertical resize -2<CR>')
keymap('n', '<C-A-h>', '<cmd> vertical resize +2<CR>')
keymap({ 'n', 't' }, '<C-Left>', '<C-w>h', opts)
keymap({ 'n', 't' }, '<C-Down>', '<C-w>j', opts)
keymap({ 'n', 't' }, '<C-Up>', '<C-w>k', opts)
keymap({ 'n', 't' }, '<C-Right>', '<C-w>l', opts)
keymap('v', 'ñ', '<gv', opts, { desc = 'pasar a la siguiente pestaña' })
keymap('v', '<leader>ñ', '>gv', opts)
keymap('n', '<leader>ñ', '>>', opts)
keymap('n', 'ñ', '<<', opts, { desc = 'pasar a la siguiente pestaña' })

keymap('n', 't', '%', opts, { desc = 'pasar a la siguiente pestaña' })
keymap('v', 't', '%', opts, { desc = 'pasar a la siguiente pestaña' })
-- keymap('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'activar/desactivar linea de numeros' })
-- keymap('n', '<leader>rn', '<cmd>set rnu!<CR>', { desc = 'activar/desactivar numeros relativos' })
------------------------------------------- ui -----------------------------
-- ui.bufferline
keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', opts, { desc = '(bufferL) pasar a la siguiente pestaña' })
keymap('n', '<A-n>', ':BufferLineMovePrev<CR>', opts, { desc = '(bufferL) mover la pestaña hacia la izq' })
keymap('n', '<A-m>', ':BufferLineMoveNext<CR>', opts, { desc = '(bufferL) mover la pestaña hacia la der' })
keymap('n', '<A-p>', ':BufferLineTogglePin<CR>', opts, { desc = '(bufferL) pin pestaña' })
-- ui.nvimtree
keymap('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = '(nvimtree) abrir tree' })
vim.keymap.set('n', '<leader>e', function()
  if vim.fn.bufname():match('NvimTree_') then
    vim.cmd.wincmd('p')
  else
    vim.cmd('NvimTreeFindFile')
  end
end, { desc = 'nvim-tree: toggle' })
-- keymap('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = '(nvimtree) enfocar tree' })
-- function start_telescope(telescope_mode)
--   local node = require('nvim-tree.lib').get_node_at_cursor()
--   local abspath = node.link_to or node.absolute_path
--   local is_folder = node.open ~= nil
--   local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ':h')
--   require('telescope.builtin')[telescope_mode]({
--     cwd = basedir,
--   })
-- end
-- keymap('n', 'C-f>', ':lua start_telescope("find_files")<CR>', opts)
-- ui.telescope
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts, { desc = '(telescope) buscar archivos' })
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts, { desc = '(telescope) buscar coincidencias' })
keymap('n', '<leader>fm', ':TodoTelescope<CR>', opts, { desc = '(telescope) buscar todos-comments' })
keymap('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', opts)
keymap('n', '<leader>fn', '<Cmd>Telescope notify<CR>', opts)
-- ui.ufo
keymap('n', '<C-ñ>', ':normal! zc<CR>', { silent = true }, { desc = '(ufo) plegar' })
keymap('n', 'ñ', ':normal! zo<CR>', { silent = true }, { desc = '(ufo) desplegar' })
-- keymap('n', '<A-a>', ':normal! zM<CR>', { silent = true }, { desc = '(ufo) plegar todo' })
keymap('n', '<A-a>', function()
  if is_folded then
    vim.cmd('normal! zR')
    is_folded = false
  else
    vim.cmd('normal! zM')
    is_folded = true
  end
end, { silent = true, desc = '(ufo) alternar plegado/desplegado' })

vim.keymap.set('n', '<C-k>', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    if vim.fn.exists(':CocActionAsync') == 1 then
      vim.fn.CocActionAsync('definitionHover')
    else
      vim.lsp.buf.hover()
    end
  end
end, { silent = true }, { desc = '(ufo) ver informacion hover pliegue' })
------------------------------------------- tools -----------------------------
-- tools.comments
keymap('n', '<leader>cl', 'gcc', { desc = '(comments-nvim) comentar linea', remap = true })
keymap('v', '<leader>c', 'gc', { desc = '(comments-nvim) comentar bloque', remap = true })
-- tools.move
keymap('n', '<A-j>', ':MoveLine(1)<CR>', opts, { desc = '(move) mover linea hacia abajo', remap = true })
keymap('n', '<A-k>', ':MoveLine(-1)<CR>', opts, { desc = '(move) mover linea hacia arriba', remap = true })
keymap('v', '<A-j>', ':MoveBlock(1)<CR>', opts, { desc = '(move) mover bloque hacia arriba', remap = true })
keymap('v', '<A-k>', ':MoveBlock(-1)<CR>', opts, { desc = '(move) mover bloque hacia abajo', remap = true })
-- tools.Vim-dadbod-ui
keymap('n', '<leader><leader>db', ':tab DBUI<CR>', opts)
keymap('n', '<leader><leader>dc', ':DBUIClose<CR>', opts)
keymap('n', '<leader><leader>cd', ':DBUIAddConnection<CR>', opts)
-- tools.nvim-dap
keymap('n', '<leader>dt', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', opts)
keymap('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>', opts)
keymap('n', '<leader>do', '<cmd>lua require"dap".step_over()<CR>', opts)
--tools.nvim-dap-ui
keymap('n', '<leader>du', "<cmd>lua require'dapui'.toggle({reset=true})<CR>", opts)
--tools.neogen
keymap('n', '<leader>n', ':Neogen<CR>', opts)

------------------------------------------- others -----------------------------
-- lsp
keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
keymap('n', 'gD', '<cmd>Telescope lsp_declarations<CR>', opts)
keymap('n', 'gI', '<cmd>Telescope lsp_implementations<CR>', opts)
keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', 'H', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- keymap('i', '<leader>w', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
keymap('n', '<leader><leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
keymap('n', '<leader>le', '<cmd>lua vim.lsp.codelens.refresh()<CR>', opts)
-- jvm
keymap('n', '<leader>jo', "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
keymap('n', '<leader>jv', "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
keymap('n', '<leader>jc', "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
keymap('n', '<leader>jm', "<Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
keymap('n', '<leader>tm', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
keymap('n', '<leader>tc', "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
keymap('n', '<leader>ju', '<Cmd>JdtUpdateConfig<CR>', opts)
keymap('n', '<F4>', '<Cmd>JdtCompile full<CR>', opts)

keymap('n', '<leader>hk', function()
  print('Lista de keybindings:')
  vim.cmd('map')
end, opts)
