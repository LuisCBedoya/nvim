local keymap = vim.keymap.set

-- Módulo con el REGISTRO de keymaps propios (lo usa el Cheat Sheet).
local M = {}
M.registry = {} -- { { cat, mode, lhs, desc }, ... }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Categoría activa (se cambia con section())
local current_cat = 'General'

--- Cambia la categoría activa para los siguientes keymaps.
local function section(name)
  current_cat = name
end

--- Registra un keymap en el Cheat Sheet y lo crea.
--- Por defecto aplica noremap + silent; si se pasa `remap = true`, lo respeta.
local function map(mode, lhs, rhs, desc, opts)
  local mode_str = type(mode) == 'table' and table.concat(mode, '/') or mode
  table.insert(M.registry, { cat = current_cat, mode = mode_str, lhs = lhs, desc = desc })

  opts = vim.tbl_extend('force', { desc = desc }, opts or {})
  if not opts.remap then
    opts.noremap = true
    opts.silent = true
  end
  keymap(mode, lhs, rhs, opts)
end

-- Estado de los toggles de visibilidad
local bufferline_visible = true
local lualine_visible = true

-- ═══════════════════════════════════════════════════════════════════
-- NATIVO · EDICIÓN
-- ═══════════════════════════════════════════════════════════════════
section('Nativo · Edición')

-- [nativo] Copiar la selección al portapapeles del sistema
map('v', '<leader>y', '"+y', 'Copiar al portapapeles')

-- [nativo] Guardar el archivo
map('n', '<C-s>', '<cmd>w<CR>', 'Guardar archivo')

-- [nativo] Cerrar el buffer actual (mantiene la ventana abierta)
map('n', '<leader>x', '<cmd>bd<CR>', 'Cerrar buffer')

-- [nativo] Cerrar buffer; si es el último, salir de Neovim
map('n', '<leader>q', function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs > 1 then
    vim.cmd('bdelete')
  else
    vim.cmd('quit')
  end
end, 'Cerrar buffer / salir')

-- [nativo] Guardar y salir
map('n', '<leader>Q', '<cmd>w<CR><cmd>q<CR>', 'Guardar y salir')

-- [nativo] Salir de insert a normal escribiendo jk
map('i', 'jk', '<ESC>', 'Salir de insert (jk)')

-- [nativo] Borrar la palabra anterior (Alt/Ctrl + Backspace)
map('i', '<A-BS>', '<C-w>', 'Borrar palabra anterior')
map('i', '<C-BS>', '<C-w>', 'Borrar palabra anterior')

-- [nativo] Unir la línea siguiente (J)
map('n', '<leader>j', 'J', 'Unir línea')
map('v', '<leader>j', 'J', 'Unir selección')

-- [nativo] Borrar desde el cursor hasta el fin de línea
map('n', '<A-0>', 'd$', 'Borrar hasta fin de línea')

-- [nativo] Seleccionar la línea completa (visual línea)
map('n', 'v', 'V', 'Seleccionar línea (visual)')

-- [nativo] Indentar / desindentar manteniendo la selección
map('v', 'ñ', '<gv', 'Reindentar selección')
map('v', '<leader>ñ', '>gv', 'Indentar selección')
map('n', '<leader>ñ', '>>', 'Indentar línea')
map('n', 'ñ', '<<', 'Desindentar línea')

-- [nativo] Saltar entre pares {} [] ()
map('n', 't', '%', 'Saltar a par {} [] ()')
map('v', 't', '%', 'Saltar a par {} [] ()')

-- [nativo] Alternar visibilidad de números de línea
map('n', '<leader>tn', '<cmd>set nu!<CR>', 'Alternar números de línea')
map('n', '<leader>tr', '<cmd>set rnu!<CR>', 'Alternar números relativos')

-- Deshabilitados (documentados):
-- map('n', '<C-u>', '{', 'Subir párrafo')
-- map('n', '<C-d>', '}', 'Bajar párrafo')

-- ═══════════════════════════════════════════════════════════════════
-- LSP · CÓDIGO
-- ═══════════════════════════════════════════════════════════════════
section('LSP · Código')

-- [conform] Formatear el buffer (normal y visual)
map({ 'n', 'v' }, '<leader>af', function()
  require('plugins.core.feedback').format()
end, 'Formatear buffer')

-- [nvim-lint] Lintear el buffer actual (ESLint, Stylelint, HTMLHint, ...)
map('n', '<leader>al', function()
  require('plugins.core.feedback').lint()
end, 'Lintear buffer')

-- [feedback] Mostrar estado del IDE (LSP / formatter / linter)
map('n', '<leader>ai', function()
  require('plugins.core.feedback').status()
end, 'Estado del IDE')

-- Keymaps LSP (buffer-local): se registran en el Cheat Sheet y se aplican
-- al conectar un servidor (autocmd LspAttach).
local lsp_keymaps = {
  { 'n', 'gd', vim.lsp.buf.definition, 'Ir a definición' },
  { 'n', 'K', vim.lsp.buf.hover, 'Hover / documentación' },
  { 'n', '<leader>rn', vim.lsp.buf.rename, 'Renombrar símbolo' },
  { 'n', '<leader>ca', vim.lsp.buf.code_action, 'Acciones de código' },
  {
    'n',
    '<leader>f',
    function()
      vim.lsp.buf.format({ async = true })
    end,
    'Formatear (LSP)',
  },
}
for _, k in ipairs(lsp_keymaps) do
  table.insert(M.registry, { cat = 'LSP · Código', mode = k[1], lhs = k[2], desc = k[4] })
end
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true }),
  callback = function(ev)
    for _, k in ipairs(lsp_keymaps) do
      vim.keymap.set(k[1], k[2], k[3], {
        noremap = true,
        silent = true,
        buffer = ev.buf,
        desc = k[4],
      })
    end
  end,
})

-- ═══════════════════════════════════════════════════════════════════
-- UI
-- ═══════════════════════════════════════════════════════════════════

-- ── Bufferline ────────────────────────────────────────────────────
section('UI · Bufferline')

-- [bufferline] Ir al siguiente buffer
map('n', '<Tab>', ':BufferLineCycleNext<CR>', 'Siguiente buffer')

-- [bufferline] Mostrar/ocultar la barra de buffers
map('n', '<leader>tb', function()
  bufferline_visible = not bufferline_visible
  vim.o.showtabline = bufferline_visible and 2 or 0
end, 'Toggle bufferline')

-- ── Lualine ───────────────────────────────────────────────────────
section('UI · Lualine')

-- [lualine] Mostrar/ocultar la barra de estado
map('n', '<leader>tl', function()
  lualine_visible = not lualine_visible
  if lualine_visible then
    require('lualine').hide({ unhide = true })
  else
    require('lualine').hide()
  end
end, 'Toggle lualine')

-- ── Nvim-tree ─────────────────────────────────────────────────────
section('UI · Nvim-tree')

-- [nvim-tree] Mostrar/ocultar el explorador de archivos
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', 'Explorador de archivos')

-- ── Telescope ─────────────────────────────────────────────────────
section('UI · Telescope')

-- [telescope] Buscar archivos por nombre
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', 'Buscar archivos')

-- [telescope] Buscar texto en el proyecto (live grep)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', 'Buscar texto')

-- [telescope + todo-comments] Buscar comentarios TODO/FIXME/NOTE...
map('n', '<leader>fm', ':TodoTelescope<CR>', 'Buscar TODOs')

-- [telescope + nvim-notify] Buscar en el historial de notificaciones
map('n', '<leader>fn', '<Cmd>Telescope notify<CR>', 'Historial de notificaciones')

-- ── Smear-cursor ──────────────────────────────────────────────────
section('UI · Smear-cursor')

-- [smear-cursor] Activar/desactivar la animación del cursor
map('n', '<leader>ts', '<cmd>SmearCursorToggle<CR>', 'Toggle smear cursor')

-- ═══════════════════════════════════════════════════════════════════
-- TOOLS
-- ═══════════════════════════════════════════════════════════════════

-- ── Pane-resizer ──────────────────────────────────────────────────
section('Tools · Pane-resizer')

-- [pane-resizer] Activar/desactivar el redimensionado de ventanas
map('n', '<leader>tp', '<cmd>PaneResizerToggle<CR>', 'Toggle pane resizer')

-- ── Comments ──────────────────────────────────────────────────────
section('Tools · Comments')

-- [nvim-comment] Comentar/descomentar la línea actual
map('n', '<leader>cl', 'gcc', 'Comentar línea', { remap = true })

-- [nvim-comment] Comentar/descomentar la selección
map('v', '<leader>c', 'gc', 'Comentar selección', { remap = true })

-- ── Move ──────────────────────────────────────────────────────────
section('Tools · Move')

-- [move.nvim] Mover la línea actual hacia abajo/arriba
map('n', '<A-j>', ':MoveLine(1)<CR>', 'Mover línea abajo', { remap = true })
map('n', '<A-k>', ':MoveLine(-1)<CR>', 'Mover línea arriba', { remap = true })

-- [move.nvim] Mover el bloque seleccionado hacia abajo/arriba
map('v', '<A-j>', ':MoveBlock(1)<CR>', 'Mover bloque abajo', { remap = true })
map('v', '<A-k>', ':MoveBlock(-1)<CR>', 'Mover bloque arriba', { remap = true })

-- ── Snipe ─────────────────────────────────────────────────────────
section('Tools · Snipe')

-- [snipe] Abrir el menú de buffers (salto rápido)
map('n', '<S-u>', ':lua require("snipe").open_buffer_menu()<CR>', 'Menú de buffers')

-- ═══════════════════════════════════════════════════════════════════
-- AYUDA
-- ═══════════════════════════════════════════════════════════════════
section('Ayuda')

-- [telescope] Cheat Sheet: ver y buscar todos los keymaps propios
map('n', '<leader>?', function()
  require('config.cheatsheet').telescope()
end, 'Cheat Sheet (keymaps)')

return M
