local M = {}
local icons = require('plugins.ui.icons.icons')
local use_icons = true
local function diagnostics_indicator(num, _, diagnostics, _)
  local result
  local symbols = {
    error = icons.diagnostics.Error,
    warning = icons.diagnostics.Warning,
    info = icons.diagnostics.Information,
  }
  if not use_icons then
    return '(' .. num .. ')'
  end
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. ' ' .. count)
    end
  end
  result = table.concat(result, ' ')
  return #result > 0 and result or ''
end

M.config = {
  options = {
    color_icons = true,
    numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = function(bufnum)
      require('auto-bufferline.configs.utils').bufremove(bufnum)
    end,
    right_mouse_command = function(bufnum)
      require('auto-bufferline.configs.utils').bufremove(bufnum)
    end,
    left_mouse_command = 'buffer %d',
    middle_mouse_command = nil,
    indicator_icon = nil,
    indicator = { style = 'icon', icon = icons.bufferline.BoldLineLeft },
    buffer_close_icon = icons.bufferline.Close,
    modified_icon = icons.bufferline.Circle,
    close_icon = icons.bufferline.Close,
    left_trunc_marker = icons.bufferline.ArrowCircleLeft,
    right_trunc_marker = icons.bufferline.ArrowCircleRight,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    diagnostics = false, -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = diagnostics_indicator,
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory',
        text_align = 'left',
        padding = 1,
      },
      {
        filetype = 'lazy',
        text = 'Lazy',
        highlight = 'PanelHeading',
        padding = 1,
      },
    },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = { '', '' }, -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
  highlights = {
    fill = {
      fg = '#aaaaaa',
      bg = '#181818',
    },
    background = {
      fg = '#aaaaaa',
      bg = '#181818',
    },
    buffer_visible = {
      fg = '#aaaaaa',
      bg = '#181818',
    },
    close_button = {
      fg = '#aaaaaa',
      bg = '#181818',
    },
    close_button_visible = {
      fg = '#aaaaaa',
      bg = '#181818',
    },
    tab_selected = {
      fg = '#ffffff',
      bg = '#0f0f0f',
      bold = true,
    },
    tab = {
      fg = '#aaaaaa',
      bg = '#181818',
    },
    tab_close = {
      fg = '#ff5f5f', -- color rojo claro para cerrar
      bg = '#181818',
    },
    duplicate_selected = {
      fg = '#ffffff',
      bg = '#0f0f0f',
      underline = true,
    },
    duplicate_visible = {
      fg = '#aaaaaa',
      bg = '#181818',
      underline = true,
    },
    duplicate = {
      fg = '#aaaaaa',
      bg = '#181818',
      underline = true,
    },

    modified = {
      fg = '#e0af68',
      bg = '#181818',
    },
    modified_selected = {
      fg = '#e0af68',
      bg = '#0f0f0f',
    },
    modified_visible = {
      fg = '#e0af68',
      bg = '#181818',
    },

    separator = {
      fg = '#181818',
      bg = '#181818',
    },
    trunc_marker = {
      fg = '#aaaaaa',
      bg = '#181818',
    },
    separator_selected = {
      fg = '#0f0f0f',
      bg = '#0f0f0f',
    },
    -- indicator_selected = {
    --   fg = '#00ffcc',
    --   bg = '#0f0f0f',
    -- },
    -- indicator_visible = {
    --   fg = '#00ffcc',
    --   bg = '#181818',
    -- },
  },
}
return M
