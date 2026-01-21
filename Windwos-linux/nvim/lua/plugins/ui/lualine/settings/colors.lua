local palette = require('theme.ples.palette')

local ples_lualine = {}

ples_lualine.normal = {
  a = { fg = palette.editor_bg, bg = palette.cyan, gui = 'bold' }, -- background2 -> black, teal1 -> cyan
  b = { fg = palette.light_gray, bg = palette.status_bar }, -- text -> white, background1 -> gray1
  c = { fg = palette.light_gray, bg = palette.none }, -- blueGray1 -> light_gray
}

ples_lualine.insert = {
  a = { fg = palette.editor_bg, bg = palette.light_blue, gui = 'bold' }, -- background2 -> black, blue1 -> light_blue
  b = { fg = palette.white, bg = palette.gray1 }, -- text -> white, background1 -> gray1
}

ples_lualine.visual = {
  a = { fg = palette.editor_bg, bg = palette.yellow, gui = 'bold' }, -- background2 -> black
  b = { fg = palette.white, bg = palette.gray1 }, -- text -> white, background1 -> gray1
}

ples_lualine.replace = {
  a = { fg = palette.editor_bg, bg = palette.pink, gui = 'bold' }, -- background2 -> black, pink3 -> pink
  b = { fg = palette.white, bg = palette.gray1 }, -- text -> white, background1 -> gray1
}

ples_lualine.command = {
  a = { fg = palette.editor_bg, bg = palette.yellow, gui = 'bold' }, -- background2 -> black
  b = { fg = palette.white, bg = palette.gray1 }, -- text -> white, background1 -> gray1
}

ples_lualine.inactive = {
  a = { fg = palette.dark_gray, bg = palette.gray1, gui = 'bold' }, -- blueGray3 -> dark_gray, background1 -> gray1
  b = { fg = palette.dark_gray, bg = palette.gray1 }, -- blueGray3 -> dark_gray
  c = { fg = palette.dark_gray, bg = palette.none }, -- blueGray3 -> dark_gray
}

return ples_lualine
