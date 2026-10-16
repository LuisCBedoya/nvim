-- Grafo de commits con gitgraph.nvim (integrado con diffview)
require('gitgraph').setup({
  git_cmd = 'git',
  symbols = {
    merge_commit = 'M',
    commit = '●',
  },
  format = {
    timestamp = '%H:%M:%S %d-%m-%Y',
    fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
  },
  hooks = {
    -- Enter sobre un commit -> diff de ese commit
    on_select_commit = function(commit)
      vim.cmd('DiffviewOpen ' .. commit.hash .. '^!')
    end,
    -- Selección de un rango (visual) -> diff del rango
    on_select_range_commit = function(from, to)
      vim.cmd('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
    end,
  },
})

-- Comando para abrir el grafo en un split VERTICAL (a la derecha).
-- gitgraph dibuja en la ventana actual, así que creamos el split antes.
vim.api.nvim_create_user_command('GitGraph', function()
  vim.cmd('vsplit')
  require('gitgraph').draw({}, { all = true, max_count = 500 })
end, { desc = 'Grafo de commits en split vertical' })

return {}
