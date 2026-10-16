local wk = require('which-key')

-- Conjunto de descripciones PROPIAS: filtra el popup para mostrar SOLO
-- tus keymaps (los registrados en config/keymaps.lua), no los de plugins.
local function build_desc_set()
  local set = {}
  local ok, km = pcall(require, 'config.keymaps')
  if ok and km.registry then
    for _, e in ipairs(km.registry) do
      if e.desc then
        set[e.desc] = true
      end
    end
  end
  -- Nombres de los grupos (categorías) del Cheat Sheet
  for _, g in ipairs({ 'LSP / Código', 'Comments', 'Telescope', 'Toggles' }) do
    set[g] = true
  end
  return set
end

local desc_set = build_desc_set()

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

  -- Mostrar únicamente los keymaps propios (los del Cheat Sheet)
  filter = function(mapping)
    return mapping.desc ~= nil and desc_set[mapping.desc] == true
  end,
})

wk.add({
  { '<leader>a', group = 'LSP / Código' },
  { '<leader>c', group = 'Comments' },
  { '<leader>f', group = 'Telescope' },
  { '<leader>t', group = 'Toggles' },
})
