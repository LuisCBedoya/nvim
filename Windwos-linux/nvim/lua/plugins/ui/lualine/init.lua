local M = {}
_G.switch = function(param, case_table)
  local case = case_table[param]
  if case then
    return case()
  end
  local def = case_table['default']
  return def and def() or nil
end

M.setup = function(opts)
  local component = require('plugins.ui.lualine.settings.modules')
  local theme_option = opts.setOption or 'roundedall'
  component.setShowMode(opts.setMode or 0)

  local gettheme = require('plugins.ui.lualine.settings.template')
  local theme = gettheme.rounded()
  if theme_option == 'rounded' then
    theme = gettheme.rounded()
  elseif theme_option == 'roundedall' then
    theme = gettheme.roundedall()
  elseif theme_option == 'square' then
    theme = gettheme.square()
  elseif theme_option == 'vscode' then
    theme = gettheme.vscode()
  elseif theme_option == 'transparent' then
    theme = gettheme.square()
  elseif theme_option == 'triangle' then
    theme = gettheme.triangle()
  elseif theme_option == 'parallelogram' then
    theme = gettheme.parallelogram()
  elseif theme_option == 'default' then
    theme = {}
  end
  require('lualine').setup({
    options = theme.options,
    sections = theme.sections,
    inactive_sections = theme.inactive_sections,
    tabline = theme.tabline,
    extensions = theme.extensions,
  })
end

return M
