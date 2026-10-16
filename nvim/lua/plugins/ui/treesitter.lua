local parsers = {
  'lua',
  'javascript',
  'typescript',
  'tsx',
  'json',
  'bash',
  'html',
  'css',
  'java',
  'markdown',
  'markdown_inline',
  'xml',
  'http',
  'graphql',
}

-- Instala solo los parsers que falten (respecto al install_dir del plugin)
local installed = require('nvim-treesitter.config').get_installed()
local to_install = vim
  .iter(parsers)
  :filter(function(p)
    return not vim.tbl_contains(installed, p)
  end)
  :totable()

require('nvim-treesitter').install(to_install)

-- Habilitar highlighting e indentación treesitter por filetype
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require('ts_context_commentstring').setup({
  enable_autocmd = false,
})
