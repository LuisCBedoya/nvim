local wk = require("which-key")

wk.setup({
  diagnostics = {
    warn = false,
  },

  icons = {
    mappings = false, -- 🔕 sin iconos
  },

  win = {
    border = "rounded",
    padding = { 2, 2, 2, 2 },
  },

  keys = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },

  triggers = {
    { "<auto>", mode = "nixsotc" },
  },

  filter = function(mapping)
    return mapping.desc and mapping.desc ~= ""
  end,
})

-- Grupos principales
wk.add({
  { "<leader>f", group = "Telescope" },
  { "<leader>t", group = "Toggles" },
  { "<leader>b", group = "Buffers" },
  { "<leader>l", group = "Lualine" },

  -- Ocultar cosas que NO quieres ver
  -- { "<leader>e", hidden = true }, -- NvimTree
})

