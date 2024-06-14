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
  -- ************************************** ui ******************************
  --- ui.themes
  {
    'Mofiqul/vscode.nvim',
    name = 'vscode',
    lazy = false,
    priority = 1000,
    config = function()
      require('plugins.ui.vscode-theme')
    end,
  },
  --- ui.webicons
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
  --- ui.neoscroll
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('plugins.ui.neoscroll')
    end,
  },
  --- ui.statuscol
  {
    'luukvbaal/statuscol.nvim',
    config = function()
      require('plugins.ui.statuscol')
    end,
  },
  -- -- fix statuscol
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('plugins.ui.ufo')
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
  --- ui.nvimtree
  {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('plugins.ui.nvimtree')
    end,
  },
  --- ui.bufferline
  {
    'famiu/bufdelete.nvim',
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('plugins.ui.bufferline')
    end,
    -- event = 'User FileOpened',
  },
  --- ui.lualine
  {
    'nvim-lualine/lualine.nvim',
    event = 'BufWinEnter',
    config = function()
      require('plugins.ui.lualine')
    end,
  },
  --- ui.telescope
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.ui.telescope')
    end,
  },
  { 'nvim-lua/plenary.nvim' },
  --- ui.cmdline
  {
    'rcarriga/nvim-notify',
    config = function()
      require('plugins.ui.notify')
    end,
  },
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    event = 'BufWinEnter',
    config = function()
      require('plugins.ui.noice')
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
  -- autotag
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  -- ************************************** tools ******************************
  --- tools.nvim-commets
  {
    'terrortylor/nvim-comment',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('plugins.tools.comment')
    end,
  },
  --- tools.cool-substitute
  {
    'otavioschwanck/cool-substitute.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('cool-substitute').setup({
        setup_keybindings = true,
      })
    end,
  },
  { 'nicwest/vim-camelsnek' },
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
  --- tools.move
  {
    'fedepujol/move.nvim',
    event = { 'CursorHold', 'CursorMoved', 'InsertEnter', 'CmdlineEnter' },
    config = function()
      require('move').setup()
    end,
  },
  --- tools.toggleterm
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec' },
    config = function()
      require('plugins.tools.toggleterm')
    end,
  },
  --- tools.neogen
  {
    'danymat/neogen',
    cmd = { 'Neogen' },
    config = function()
      require('neogen').setup({ snippet_engine = 'luasnip' })
    end,
  },
  --- tools.snippets
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
  },
  { 'rafamadriz/friendly-snippets' },
  --- tools.todo
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('plugins.tools.todo')
    end,
  },
  --- tools.database
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = { 'DBUIToggle', 'DBUIAddConnection', 'DBUI', 'DBUIFindBuffer', 'DBUIRenameBuffer' },
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
      'tpope/vim-dotenv',
    },
    config = function()
      require('plugins.tools.database')
    end,
  },
  --- tools.jdtls
  { 'mfussenegger/nvim-jdtls' },
  --- tools.peek
  {
    'toppair/peek.nvim',
    cmd = { 'PeekOpen', 'PeekClose' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('plugins.tools.peek')
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
  -- ************************************** dap ******************************
  --- dap.nvim-dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',
    },
    cmd = { 'DapToggleBreakpoint', 'DapContinue', 'DapStepOver', 'DapStepInto', 'DapStepOut', 'DapTerminate' },
    config = function()
      require('plugins.dap.dap')
    end,
  },
  --- dap.nvim-dapui
  {
    'rcarriga/nvim-dap-ui',
    cmd = { 'DapToggleBreakpoint', 'DapContinue', 'DapStepOver', 'DapStepInto', 'DapStepOut', 'DapTerminate' },
    after = 'nvim-dap',
    config = function()
      require('plugins.dap.dapui')
    end,
  },
  --- dap.nvim-dap-python
  {
    'mfussenegger/nvim-dap-python',
    ft = 'py',
    after = 'nvim-dap',
    config = function()
      require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
    end,
  },
  -- ************************************** lsp ******************************
  --- lsp.cmp
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },

  --- lsp.conform
  { 'stevearc/conform.nvim' },

  --- lsp.lsp-mason
  { 'neovim/nvim-lspconfig' },
  { 'nvimtools/none-ls.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'williamboman/mason.nvim' },
  { 'jayp0521/mason-nvim-dap.nvim' },
  { 'jayp0521/mason-null-ls.nvim' },
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
