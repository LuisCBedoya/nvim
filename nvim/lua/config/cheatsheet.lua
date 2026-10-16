-- Cheat Sheet de keymaps propios (construido desde config.keymaps).
local M = {}

--- Abre el Cheat Sheet en un picker de Telescope (buscable y categorizado).
-- Solo muestra TUS keymaps (los registrados por el helper `map`).
function M.telescope()
  local ok_km, km = pcall(require, 'config.keymaps')
  if not ok_km or not km.registry then
    vim.notify('No se pudo leer el registro de keymaps', vim.log.levels.WARN)
    return
  end

  local ok_t, pickers = pcall(require, 'telescope.pickers')
  if not ok_t then
    vim.notify('Telescope no está disponible', vim.log.levels.WARN)
    return
  end
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  -- Copia ordenada por categoría y luego por tecla
  local entries = vim.deepcopy(km.registry)
  table.sort(entries, function(a, b)
    if a.cat == b.cat then
      return a.lhs < b.lhs
    end
    return a.cat < b.cat
  end)

  -- Ancho de la columna de categoría (en celdas de pantalla, no bytes)
  local width = 0
  for _, e in ipairs(entries) do
    width = math.max(width, vim.fn.strdisplaywidth(e.cat))
  end

  pickers.new({}, {
    prompt_title = 'Cheat Sheet · keymaps',
    finder = finders.new_table({
      results = entries,
      entry_maker = function(e)
        local cat = e.cat .. string.rep(' ', math.max(0, width - vim.fn.strdisplaywidth(e.cat)))
        return {
          value = e,
          display = string.format('%s  %-4s  %-16s  %s', cat, e.mode, e.lhs, e.desc),
          ordinal = table.concat({ e.cat, e.mode, e.lhs, e.desc }, ' '),
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = false,
  }):find()
end

return M
