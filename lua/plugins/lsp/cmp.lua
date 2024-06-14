local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
local cmp_cmdlinnes_mapping = {
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
}

vim.api.nvim_set_hl(0, 'transparentBG', { bg = 'NONE', fg = 'LightGray' })

local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

--   פּ ﯟ   some other good icons
local kind_icons = require('plugins.ui.icons.icons').kind
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<A-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<A-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping({
      i = function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end,
      c = function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end,
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },

  -- Use buffer source for `/`.
  cmp.setup.cmdline('/', {
    preselect = 'none',
    completion = {
      completeopt = 'menu,preview,menuone,noselect',
    },
    mapping = cmp_cmdlinnes_mapping,
    sources = {
      { name = 'buffer' },
    },
    experimental = {
      ghost_text = true,
      native_menu = false,
    },
  }),

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(':', {
    preselect = 'none',
    completion = {
      completeopt = 'menu,preview,menuone,noselect',
    },
    mapping = cmp_cmdlinnes_mapping,
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
    experimental = {
      ghost_text = true,
      native_menu = false,
    },
  }),

  formatting = {
    -- fields = { 'abbr', 'kind', 'menu' },
    fields = { 'abbr', 'kind' },
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = 'LSP',
        luasnip = 'Snippet',
        ['vim-dadbod-completion'] = '[DB]',
        buffer = 'Buffer',
        path = 'Path',
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = 'Normal:transparentBG,FloatBorder:transparentBG,Search:None',
      scrollbar = true,
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = 'Normal:transparentBG,FloatBorder:transparentBG,Search:None',
    }),
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
