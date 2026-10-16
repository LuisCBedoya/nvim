-- Diffs e historial con diffview.nvim
require('diffview').setup({
  enhanced_diff_hl = true, -- resaltado de diffs más detallado
  view = {
    default = { layout = 'diff2_horizontal' },
    merge_tool = { layout = 'diff3_mixed' },
    file_history = { layout = 'diff2_horizontal' },
  },
  file_panel = {
    listing_style = 'tree',
    win_config = { position = 'left', width = 35 },
  },
})

return {}
