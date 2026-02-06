local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
local cmp_cmdlinnes_mapping = {
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
}

-- Colores como VS Code Dark+
vim.api.nvim_set_hl(0, 'CmpMenuBg', { bg = '#161616' })
vim.api.nvim_set_hl(0, 'CmpItemSelBg', { bg = '#2A2D2E' })
vim.api.nvim_set_hl(0, 'CmpItemAbbr', { fg = '#cccccc' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#569cd6', bold = true })
vim.api.nvim_set_hl(0, 'CmpItemKind', { fg = '#9cdcfe' })
vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#6a9955', italic = true })

local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local kind_icons = require('plugins.ui.icons.icons').kind

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
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

  -- Configuración para búsqueda con '/'
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

  -- Configuración para comandos con ':'
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
    fields = { 'kind', 'abbr', 'menu' }, -- Orden: icono, texto, fuente
    format = function(entry, vim_item)
      -- Icono solo, sin texto del tipo
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])

      -- Texto de la fuente como VS Code
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[SNIP]',
        buffer = '[BUF]',
        path = '[PATH]',
        nvim_lua = '[API]',
        cmdline = '[CMD]',
      })[entry.source.name]

      -- Añadir un espacio antes del texto para separar del icono
      vim_item.abbr = ' ' .. vim_item.abbr

      return vim_item
    end,
  },

  sources = {
    { name = 'nvim_lsp', priority = 1000 },
    { name = 'luasnip', priority = 750 },
    { name = 'buffer', priority = 500 },
    { name = 'path', priority = 250 },
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  window = {
    completion = cmp.config.window.bordered({
      winhighlight = 'Normal:CmpMenuBg,FloatBorder:CmpMenuBg,CursorLine:CmpItemSelBg,Search:None',
      scrollbar = false, -- VS Code no tiene scrollbar en el menú
      border = 'rounded',
      col_offset = -1, -- Alinea mejor con el cursor
    }),
    documentation = cmp.config.window.bordered({
      border = 'rounded',
      winhighlight = 'Normal:CmpMenuBg,FloatBorder:CmpMenuBg',
      max_width = 60, -- Ancho máximo como VS Code
      max_height = 15, -- Alto máximo
    }),
  },

  experimental = {
    ghost_text = false, -- VS Code no tiene ghost text
    native_menu = false,
  },

  -- Ordenamiento como VS Code
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

-- Integración con autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

-- Opcional: Si quieres que el menú aparezca automáticamente
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.pumheight = 10 -- Altura del menú como VS Code
