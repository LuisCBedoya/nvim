local wk = require('which-key')

-- Grupos (categorías): una sola fuente de verdad, usada por `wk.add` y por el filtro.
local GROUPS = {
  { '<leader>a', 'LSP / Código' },
  { '<leader>c', 'Comments' },
  { '<leader>f', 'Telescope' },
  { '<leader>g', 'Git' },
  { '<leader>t', 'Toggles' },
}

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
  for _, g in ipairs(GROUPS) do
    set[g[2]] = true
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

-- Registrar los grupos (categorías) en which-key
local group_specs = {}
for _, g in ipairs(GROUPS) do
  group_specs[#group_specs + 1] = { g[1], group = g[2] }
end
wk.add(group_specs)
