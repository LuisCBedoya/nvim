--[[ _G.all_trim = function(s)
  return s:match("^%s*(.-)%s*$")
end ]]

local hide_in_width = function()
  return vim.fn.winwidth(0) > 75
end

local icons = require('plugins.ui.icons.icons')
local formatter = require('plugins.ui.lualine.settings.conform_info')

local getLeftSubstring = function(word, length)
  if #word > length then
    return string.sub(word, 1, length) .. '...'
  else
    return word
  end
end

local unique_list = function(list)
  local seen = {}
  local result = {}

  for _, val in ipairs(list) do
    if not seen[val] then
      table.insert(result, val)
      seen[val] = true
    end
  end

  return result
end

local mode_map = {
  ['NORMAL'] = 'N',
  ['INSERT'] = 'I',
  ['VISUAL'] = 'V',
  ['REPLACE'] = 'R',
  ['COMMAND'] = 'C',
  ['O-PENDING'] = 'O',
}

local mode_vs2 = {
  ['NORMAL'] = '--NORMAL--',
  ['INSERT'] = '--INSERT--',
  ['VISUAL'] = ' --VISUAL--',
  ['REPLACE'] = '--REPLACE--',
  ['COMMAND'] = '--COMMAND --',
  ['O-PENDING'] = '--O-PENDING--',
  ['V-LINE'] = '--V-LINE--',
}

local mode_vs = {
  ['NORMAL'] = 'NORMAL',
  ['INSERT'] = 'INSERT',
  ['VISUAL'] = 'VISUAL',
  ['REPLACE'] = 'REPLACE',
  ['COMMAND'] = 'COMMAND',
  ['O-PENDING'] = 'O-PENDING',
  ['V-LINE'] = 'V-LINE',
}

local mode_icon = {
  ['NORMAL'] = '',
  ['INSERT'] = '',
  ['VISUAL'] = '󰷊',
  ['REPLACE'] = '',
  ['COMMAND'] = '',
  ['O-PENDING'] = '󰌚',
}

local show_mode = ''
return {
  setShowMode = function(str)
    show_mode = str
  end,

  -- ######################### treesitter info
  treesitter = {
    function()
      return icons.lualine.Tree
    end,
    color = function()
      local has_ts, parsers = pcall(require, 'nvim-treesitter.parsers')
      if not has_ts then
        return { fg = '#E06C75' }
      end

      local lang = parsers.get_buf_lang()
      if lang and parsers.has_parser(lang) then
        return { fg = '#98C379' } -- verde si hay parser
      else
        return { fg = '#E06C75' } -- rojo si no hay
      end
    end,
    cond = hide_in_width,
  },

  -- ######################### fileType
  fileType = {
    function()
      local ft = vim.bo.filetype
      return (ft == '' and icons.lualine.llaves .. ' plain text  ') or (icons.lualine.llaves .. ' ' .. ft)
    end,
    icon_enabled = false,
    padding = 1,
  },

  codeium = {
    function()
      local status, result = pcall(vim.api.nvim_call_function, 'codeium#GetStatusString', {})
      if status then
        local codeium = result
        if codeium then
          if codeium == 'OFF' then
            return icons.lualine.CopilotOff
          else
            return icons.lualine.Copilot
          end
        else
          return ''
        end
      else
        return ''
      end
    end,
    color = function()
      local status, result = pcall(vim.api.nvim_call_function, 'codeium#GetStatusString', {})
      if status then
        local codeium = result
        if codeium then
          return { fg = codeium == 'OFF' and '#3E4452' or '#98C379' }
        else
          return {}
        end
      else
        return {}
      end
    end,
    cond = hide_in_width,
  },

  -- ######################### fileEncoding
  fileEncoding = {
    function()
      local encoding = string.upper(vim.bo.fileencoding)
      return encoding ~= '' and encoding or ''
    end,
    icon_enabled = false,
    padding = 1,
  },

  -- ######################### fileInfo
  fileInfo = {
    function()
      local icon = icons.ui.Location
      local filename = vim.fn.expand('%:t')
      if filename == '' then
        filename = 'Empty'
      end
      local ok, devicons = pcall(require, 'nvim-web-devicons')
      if ok then
        icon = devicons.get_icon(filename, vim.fn.expand('%:e'), { default = true }) or icon
      end
      return icon .. ' ' .. filename
    end,
    icon_enabled = false,
    padding = 1,
  },

  -- ######################### lsp_servers, formatters, linters info
  lsp_info = {
  function()
    local buf_ft = vim.bo.filetype
    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
    local servers = {}

    -- SERVERS LSP
    for _, client in pairs(buf_clients) do
      if client.name ~= 'copilot' then
        table.insert(servers, '󰦕 ' .. client.name)
      end
    end

    -- LINTERS (solo si están instalados)
    local lint_ok, lint = pcall(require, 'lint')
    if lint_ok then
      local linters_by_ft = lint.linters_by_ft or {}
      local ft_linters = linters_by_ft[buf_ft] or {}
      
      for _, linter_name in ipairs(ft_linters) do
        -- Verificar si el linter está instalado (ejecutable)
        local linter = lint.linters[linter_name]
        if linter and vim.fn.executable(linter.cmd or linter_name) == 1 then
          table.insert(servers, ' ' .. linter_name)
        end
      end
    end

    if #servers == 0 then
      return icons.Gear .. ' LSP Inactive'
    end

    return table.concat(servers, ', ')
  end,
  padding = 1,
  cond = hide_in_width,
},

  -- ######################### cursorPosition
  cursorPosition = {
    function()
      if vim.o.columns > 140 then
        local pos = vim.api.nvim_win_get_cursor(0)
        return string.format('Ln %d, Col %d', pos[1], pos[2] + 1)
      else
        return ''
      end
    end,
    icon_enabled = false,
    padding = 1,
  },

  -- ######################### git diff
  diff = {
    'diff',
    colored = true,
    symbols = {
      added = icons.git.LineAdded .. ' ',
      modified = icons.git.LineModified .. ' ',
      removed = icons.git.LineRemoved .. ' ',
    },
    cond = hide_in_width,
  },

  -- ######################### git branch info
  get_branch = function()
    local icon = icons.git.Branch3 or ''
    local branch = vim.b.gitsigns_head
    local suffix = ''

    if not branch or branch == '' then
      return ''
    end

    -- Sufijo '*' si el archivo está modificado
    if vim.bo.modified then
      suffix = suffix .. '*'
    end

    -- Sufijo '+' si hay cambios en el repo
    local gitsigns_status = vim.b.gitsigns_status_dict
    if
      gitsigns_status
      and (gitsigns_status.added ~= 0 or gitsigns_status.changed ~= 0 or gitsigns_status.removed ~= 0)
    then
      suffix = suffix .. '+'
    end

    return string.format('%s %s%s', icon, branch, suffix)
  end,

  -- ######################### diagnostics
  diagnostics = {
    function()
      if not rawget(vim, 'lsp') then
        return ' 0  0'
      end

      local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

      local result = string.format(' %d  %d', errors, warnings)

      if hints > 0 then
        result = result .. string.format('  %d', hints)
      end

      if info > 0 then
        result = result .. string.format('  %d', info)
      end

      return vim.o.columns > 100 and result or ''
    end,
    padding = { left = 1, right = 1 },
    cond = function()
      return vim.o.columns > 100
    end,
  },

  -- ######################### space or tabs info
  spaces = {
    function()
      -- local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      -- local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { scope = "buf", bufnr = 0 })
      local shiftwidth = vim.fn.shiftwidth()
      return icons.lualine.Tab .. ' ' .. shiftwidth
    end,
    padding = 1,
  },

  -- ######################### lazy update

  lazy_updates = {
    function()
      local lazy_status = require('lazy.status')
      if lazy_status.has_updates() then
        return lazy_status.updates()
      end
      return ''
    end,
    cond = function()
      return require('lazy.status').has_updates()
    end,
    padding = 1,
  },

  -- ######################### noice
  noice_command = {
    function()
      local noice = require('noice')
      if noice.api.status.command.has() then
        return ' ' .. noice.api.status.command.get()
      end
      return ''
    end,
    cond = function()
      return package.loaded['noice'] and require('noice').api.status.command.has()
    end,
    padding = 1,
  },
  noice_mode = {
    function()
      local noice = require('noice')
      if noice.api.status.mode.has() then
        return ' ' .. noice.api.status.mode.get()
      end
      return ''
    end,
    cond = function()
      return package.loaded['noice'] and require('noice').api.status.mode.has()
    end,
    color = function()
      return { fg = '#fab387' } -- naranja suave
    end,
    padding = 1,
  },

  -- ######################### path info
  path = {
    'filename',
    file_status = true,
    path = 1,
    fmt = function(str)
      return '[' .. str .. ']'
    end,
    cond = hide_in_width,
  },

  -- ######################### modes
  mode_vscode = {
    -- 'mode',
    -- fmt = function(str)
    --   return '%#St_Mode#' .. string.format('  %s ', mode_vs[str])
    -- end,
    'mode',
    fmt = function(str)
      return mode_vs2[str]
    end,
  },

  mode_rounded = {
    'mode',
    padding = 1,
    separator = { left = '' },
    fmt = function(str)
      if show_mode == 1 then
        return icons.lualine.Neovim .. ' ' .. (mode_map[str] or str)
      elseif show_mode == 2 then
        return icons.lualine.Neovim
      elseif show_mode == 3 then
        return (mode_map[str] or str)
      elseif show_mode == 4 then
        return nil
      elseif show_mode == 5 then
        return (mode_icon[str] or str)
      else
        return icons.lualine.Neovim .. ' ' .. str
      end
    end,
  },

  mode_roundedall = {
    'mode',
    padding = 1,
    separator = { left = '', right = '' },
    fmt = function(str)
      if show_mode == 1 then
        return icons.lualine.Neovim .. ' ' .. str:sub(1, 1)
      elseif show_mode == 2 then
        return icons.lualine.Neovim
      elseif show_mode == 3 then
        return str:sub(1, 1)
      elseif show_mode == 4 then
        return nil
      elseif show_mode == 5 then
        return (mode_icon[str] or str)
      else
        return icons.lualine.Neovim .. ' ' .. str
      end
    end,
  },

  mode_triangle = {
    'mode',
    padding = 1,
    separator = { left = '', right = '' },
    fmt = function(str)
      if show_mode == 1 then
        return icons.lualine.Neovim .. ' ' .. (mode_map[str] or str)
      elseif show_mode == 2 then
        return icons.lualine.Neovim
      elseif show_mode == 3 then
        return (mode_map[str] or str)
      elseif show_mode == 4 then
        return nil
      elseif show_mode == 5 then
        return (mode_icon[str] or str)
      else
        return icons.lualine.Neovim .. ' ' .. str
      end
    end,
  },

  mode_parallelogram = {
    'mode',
    padding = 1,
    separator = { left = '', right = '' },
    fmt = function(str)
      if show_mode == 1 then
        return icons.lualine.Neovim .. ' ' .. (mode_map[str] or str)
      elseif show_mode == 2 then
        return icons.lualine.Neovim
      elseif show_mode == 3 then
        return (mode_map[str] or str)
      elseif show_mode == 4 then
        return nil
      elseif show_mode == 5 then
        return (mode_icon[str] or str)
      else
        return icons.lualine.Neovim .. ' ' .. str
      end
    end,
  },

  mode_square = {
    'mode',
    padding = 1,
    separator = { left = '' },
    fmt = function(str)
      if show_mode == 1 then
        return icons.lualine.Neovim .. ' ' .. (mode_map[str] or str)
      elseif show_mode == 2 then
        return icons.lualine.Neovim
      elseif show_mode == 3 then
        return (mode_map[str] or str)
      elseif show_mode == 4 then
        return nil
      elseif show_mode == 5 then
        return (mode_icon[str] or str)
      else
        return icons.lualine.kNeovim .. ' ' .. str
      end
    end,
  },

  -- ######################### colors
  mode_colors = {
    n = '#3a3d4a', -- normal
    no = '#3a3d4a',
    cv = '#3a3d4a',
    ce = '#3a3d4a',
    t = '#2f313c', -- terminal
    i = '#2f313c', -- insert
    ic = '#2f313c',
    v = '#6b6e76', -- visual
    V = '#5a5d66',
    [''] = '#4c4f57', -- visual block
    c = '#454852', -- command
    s = '#62656d', -- select
    S = '#5a5d65',
    [''] = '#4a4d55', -- select block
    R = '#7c7f87', -- replace
    Rv = '#70737b',
    r = '#888b93', -- hit-enter prompt
    rm = '#7e8189', -- more prompt
    ['r?'] = '#767981', -- confirm
  },
}
