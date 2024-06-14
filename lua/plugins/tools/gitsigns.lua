require('gitsigns').setup({
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '▎' },
    -- topdelete = { text = '‾' },
    topdelete = { text = '▬' },
    changedelete = { text = '~' },
    untracked = { text = '▎' },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = true,
  },
})

vim.cmd([[
  highlight GitSignsDelete guifg=#ea7676
  highlight GitSignsChange guifg= #017bcd
  highlight GitSignsAdd guifg=#54bc5c
  ]])
