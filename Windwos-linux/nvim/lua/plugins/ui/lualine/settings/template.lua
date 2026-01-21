local icons = require('plugins.ui.icons.icons')
local M = {}

local component = require('plugins.ui.lualine.settings.modules')
local theme_ples_lualine = require('plugins.ui.lualine.settings.colors')
local treesitter = component.treesitter
local lsp_info = component.lsp_info
local diagnostics = component.diagnostics
local diff = component.diff
local spaces = component.spaces
local cursor_position = component.cursorPosition
local file_encoding = component.fileEncoding
local fileInfo = component.fileInfo
local lazy_update = component.lazy_updates
local noice_command = component.noice_command
local noice_mode = component.noice_mode
local fileType = component.fileType
local get_branch = component.get_branch
local lsp_progress = {}
local data_ok, lspprogress = pcall(require, 'lsp-progress')
if data_ok then
  lsp_progress = lspprogress.progress
end
local codeium = component.codeium

M.filetype = {
  'TelescopePrompt',
  'packer',
  'alpha',
  'dashboard',
  'NvimTree',
  'Outline',
  'DressingInput',
  'toggleterm',
  'lazy',
  'mason',
  'neo-tree',
  'startuptime',
  'crunner',
  'lspinfo',
  'mysql',
  'dbui',
  'dbout',
}

M.vscode = function()
  local mode = component.mode_vscode
  return {
    options = {
      theme = theme_ples_lualine,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      -- disabled_filetypes = M.filetype,
      always_divide_middle = false,
    },
    sections = {
      lualine_a = {
        {
          -- Colored mode icon
          function()
            return icons.ui.Target
          end,
          color = function()
            return { fg = '#FFFFFF', bg = component.mode_colors[vim.fn.mode()] }
          end,
          -- separator = { left = '', right = '' },
          -- padding = { left = 1, right = 1 },
        },
      },
      lualine_b = {
        get_branch,
        diff,
        diagnostics,
        mode,
        {
          function()
            return '%='
          end,
        },
        noice_command,
        -- noice_mode,
        cursor_position,
        spaces,
        file_encoding,
        fileType,
        codeium,
        lazy_update,
        lsp_info,
        {
          function()
            return ' █'
          end,
          color = function()
            return { fg = component.mode_colors[vim.fn.mode()] }
          end,
          padding = { right = 0 },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

M.rounded = function()
  local mode = component.mode_rounded
  return {
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = M.filetype,
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        mode,
      },
      lualine_b = { get_branch },
      lualine_c = { diff, lsp_info, lsp_progress },
      lualine_x = { diagnostics, spaces, codeium, treesitter, 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {
        { 'location', separator = { right = '' }, padding = 1 },
        -- { 'location', separator = { right = '' }, padding = 0 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  }
end

M.roundedall = function()
  local mode = component.mode_roundedall
  return {
    options = {
      theme = colorscheme,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = M.filetype,
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        mode,
      },
      lualine_b = { get_branch },
      lualine_c = { diff, lsp_info, lsp_progress },
      lualine_x = { diagnostics, spaces, codeium, treesitter, 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {
        { 'location', separator = { right = '', left = '' }, padding = 1 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  }
end

M.triangle = function()
  local mode = component.mode_triangle
  return {
    options = {
      theme = colorscheme,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = M.filetype,
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        mode,
      },
      lualine_b = { get_branch },
      lualine_c = { diff, lsp_info, lsp_progress },
      lualine_x = { diagnostics, spaces, codeium, treesitter, 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {
        { 'location', separator = { right = '', left = '' }, padding = 1 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  }
end

M.parallelogram = function()
  local mode = component.mode_parallelogram
  return {
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = M.filetype,
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        mode,
      },
      lualine_b = { get_branch },
      lualine_c = { diff, lsp_info, lsp_progress },
      lualine_x = { diagnostics, spaces, codeium, treesitter, 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {
        { 'location', separator = { right = '', left = '' }, padding = 1 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  }
end

M.square = function()
  local mode = component.mode_square
  return {
    options = {
      theme = colorscheme,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = M.filetype,
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        mode,
      },
      lualine_b = { get_branch },
      lualine_c = { diff, lsp_info, lsp_progress },
      lualine_x = { diagnostics, spaces, codeium, treesitter, 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {
        { 'location', separator = { right = '' }, padding = 1 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  }
end

return M
