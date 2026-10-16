require('nvim_comment').setup({
  comment_empty = false,
  hook = function()
    if vim.bo.filetype ~= '' then
      require('ts_context_commentstring.internal').update_commentstring()
    end
  end,
})
