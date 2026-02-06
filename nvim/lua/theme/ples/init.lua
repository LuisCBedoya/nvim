local M = {}

local config = {
  bold_vert_split = false,
  dark_variant = 'main',
  disable_background = false,
  disable_float_background = false,
  disable_italics = false,
  dim_nc_background = false,

  groups = {
    -- Fondos y bordes
    background = 'black1', -- #1b1e28 (editor.background)
    panel = 'darker_black', -- #171922 (activityBar.background)
    border = 'gray3', -- #303030 (editorIndentGuide.background)

    -- Texto y sintaxis
    comment = 'dark_gray', -- #767c9d (comment)
    link = 'blue', -- #ADD7FF (textLink.foreground)
    punctuation = 'dark_blue', -- #91B4D5 (entity.name)

    -- Diagnosticos
    error = 'pink', -- #d0679d (errorForeground)
    hint = 'light_blue', -- #89ddff (terminal.ansiBrightBlue)
    info = 'blue', -- #ADD7FF (textLink.foreground)
    warn = 'yellow', -- #fffac2 (editorWarning.foreground)

    -- Git
    git_add = 'git_add', -- #5fb3a1 (gitDecoration.addedResourceForeground)
    git_change = 'git_change', -- #ADD7FF (gitDecoration.modifiedResourceForeground)
    git_delete = 'git_delete', -- #d0679d (gitDecoration.deletedResourceForeground)
    git_dirty = 'blue', -- #ADD7FF
    git_ignore = 'git_ignore', -- #767c9d70 (gitDecoration.ignoredResourceForeground)
    git_merge = 'purple', -- #f087bd (terminal.ansiMagenta)
    git_rename = 'cyan', -- #5DE4c7 (gitDecoration.renamedResourceForeground)
    git_stage = 'light_blue', -- #89ddff (terminal.ansiBrightBlue)
    git_text = 'cyan', -- #5DE4c7

    -- Encabezados (Markdown y otros)
    headings = {
      h1 = 'cyan', -- #5DE4c7
      h2 = 'yellow', -- #fffac2
      h3 = 'pink', -- #d0679d
      h4 = 'purple', -- #f087bd
      h5 = 'light_blue', -- #89ddff
      h6 = 'blue', -- #ADD7FF
    },
  },
  highlight_groups = {},
}

function M.setup(opts)
  opts = opts or {}

  -- Manejo de encabezados como string único
  if opts.groups and type(opts.groups.headings) == 'string' then
    opts.groups.headings = {
      h1 = opts.groups.headings,
      h2 = opts.groups.headings,
      h3 = opts.groups.headings,
      h4 = opts.groups.headings,
      h5 = opts.groups.headings,
      h6 = opts.groups.headings,
    }
  end

  -- Actualizar configuración
  config.user_variant = opts.dark_variant or nil
  config = vim.tbl_deep_extend('force', config, opts)
end

function M.colorscheme()
  if vim.g.colors_name then
    vim.cmd('hi clear')
  end

  vim.opt.termguicolors = true
  vim.g.colors_name = 'ples'

  local theme = require('theme.ples.theme').get(config)

  -- Aplicar highlights del tema
  for group, color in pairs(theme) do
    if config.highlight_groups[group] == nil then
      require('theme.ples.utils').highlight(group, color)
    end
  end

  -- Aplicar overrides del usuario
  for group, color in pairs(config.highlight_groups) do
    require('theme.ples.utils').highlight(group, color)
  end
end

return M
