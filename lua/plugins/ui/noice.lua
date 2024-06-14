local cmp = require('cmp')
require('noice').setup({
  -- timeout = 3500,
  stages = 'static',
  -- cmdline = {
  --   view = 'cmdline',
  -- },
  views = {
    cmdline_popup = {
      position = {
        row = 0,
        col = '50%',
      },
      size = {
        width = 60,
        height = 'auto',
      },
    },
  },
  messages = {
    enabled = true,
  },
  notify = {
    enabled = true,
  },
  lsp = {
    progress = {
      enabled = false,
    },
    hover = {
      enabled = true,
    },
    signature = {
      enabled = true,
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = false,
    },
  },
})
