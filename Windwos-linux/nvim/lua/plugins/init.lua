local icons = require('plugins.ui.icons.icons')
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
  -- SECTION: UI  #######################################################################
  {
    'Mofiqul/vscode.nvim',
     name = 'vscode',
     lazy = false,
     priority = 1000,
     config = function()
       require('plugins.ui.vscode-theme')
     end,
   },
     {
    'nvim-tree/nvim-web-devicons',
    opts = function()
      return { override = require('plugins.ui.icons.devicons') }
    end,
    config = function(_, opts)
      require('nvim-web-devicons').setup(opts)
    end,
  },
  --- ui.rainbow

  { 'hiphish/rainbow-delimiters.nvim' },
  --- ui.highlight-undo
  {
    'tzachar/highlight-undo.nvim',
    config = function()
      require('plugins.ui.highlight-undo')
    end,
  },
  --- ui.autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('plugins.ui.autopairs')
    end,
  },
  --- ui.colorizer
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = function()
      require('colorizer').setup()
    end,
  },
  --- ui.indent-blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.ui.indent-blankline')
    end,
  },
  --- ui.iluminate
  {
    'RRethy/vim-illuminate',
    config = function()
      require('plugins.ui.iluminate')
    end,
  },
  --- ui.barbecue
  {
    'utilyre/barbecue.nvim',
    event = { 'BufEnter', 'FileType' },
    config = function()
      require('plugins.ui.barbecue')
    end,
  },
  {
    'SmiteshP/nvim-navic',
  },
  -- ui.buffernline
    {
    'famiu/bufdelete.nvim',
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      vim.opt.termguicolors = true
      local config = require('plugins.ui.bufferline').config()
      require('bufferline').setup(config)
    end,
    -- event = 'User FileOpened',
  },
  -- ui.lualine
    {
    'nvim-lualine/lualine.nvim',
    event = { 'InsertEnter', 'BufRead', 'BufNewFile' },
    config = function()
      local lualine = require('plugins.ui.lualine')
      -- rounded
      -- roundedall
      -- square
      -- triangle
      -- parallelogram
      -- transparent
      -- vscode
      -- default
      local options = 'vscode'
      -- 0 = on full text mode info,
      -- 1 = on initial mode + logo
      -- 2 = logo only
      -- 3 = initial only
      -- 4 = off
      -- 5 = icon
      local show_mode = 0
      lualine.setup({
        setColor = color,
        setOption = options,
        setMode = show_mode,
      })
    end,
  },
    --- ui.nvimtree
  {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('plugins.ui.nvimtree')
    end,
  },
    --- ui.telescope
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.ui.telescope')
    end,
  },
    --- ui.treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('plugins.ui.treesitter')
    end,
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
    --- ui.pane-resizer
  {
    "mboyov/pane-resizer.nvim",
    config = function()
      require("pane_resizer").setup({
        NVIMTREE_WIDTH = 35,
        FOCUSED_WIDTH_PERCENTAGE = 0.65,
      })
    end,
  },

  -- SECTION: TOOLS  #######################################################################
  {
    'fedepujol/move.nvim',

    event = { 'CursorHold', 'CursorMoved', 'InsertEnter', 'CmdlineEnter' },
    config = function()
      require('move').setup()
    end,
  },
   -- tools.autotag
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
    --- tools.nvim-commets
  {
    'terrortylor/nvim-comment',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('plugins.tools.comments')
    end,
  },
  --- tools.gitsgns
  {
    'lewis6991/gitsigns.nvim',
    cond = function()
      local git_dir = vim.fn.finddir('.git', '.;')
      return git_dir ~= ''
    end,
    config = function()
      require('plugins.tools.gitsigns')
    end,
  },
  -- tools.camelcase
  { 'nicwest/vim-camelsnek' },
  -- tools.todo-comments
  {
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('plugins.tools.todo')
    end,
  },
  {'nvim-lua/plenary.nvim'},
  --tools.neoscroll
  {
    'karb94/neoscroll.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('plugins.tools.neoscroll')
    end,
  },
  --tools.snipe
  {
    'leath-dub/snipe.nvim',
    lazy = false,
    config = function()
      require('snipe').setup()
    end,
  },
  --tools.whick-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.tools.which-key")
    end,
  },
}

local opts = {
  ui = {
    icons = {
      ft = icons.lazy.Ft,
      lazy = icons.lazy.Lazy,
      loaded = icons.lazy.Loaded,
      not_loaded = icons.lazy.Not_loaded,
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
}

require('lazy').setup(plugins, opts)
