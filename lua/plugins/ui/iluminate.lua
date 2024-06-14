require('illuminate').configure({
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  filetypes_denylist = {
    'help',
    'alpha',
    'neo-tree',
    'NvimTree',
    'Trouble',
    'lazy',
    'norg',
  },
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
})
