local blend = require('theme.ples.utils').blend
local M = {}

function M.get(config)
  local p = require('theme.ples.palette')
  local theme = {}
  local groups = config.groups or {}

  local styles = {
    italic = (config.disable_italics and p.none) or 'italic',
    vert_split = (config.bold_vert_split and groups.border) or p.none,
    background = (config.disable_background and p.none) or groups.background,
    float_background = (config.disable_float_background and p.none) or groups.panel,
  }
  styles.nc_background = (config.dim_nc_background and not config.disable_background and groups.panel)
    or styles.background

  theme = {
    -- UI Base
    ColorColumn = { bg = p.gray1 },
    Conceal = { bg = p.none },
    CurSearch = { link = 'IncSearch' },
    Cursor = { fg = p.editor_bg, bg = p.white },
    CursorColumn = { bg = p.gray1 },
    CursorLine = { bg = p.gray2 },
    CursorLineNr = { fg = p.white },
    DarkenedPanel = { bg = groups.panel },
    DarkenedStatusline = { bg = groups.panel },
    DiffAdd = { bg = blend(groups.git_add, groups.background, 0.15) },
    DiffChange = { bg = blend(groups.git_change, groups.background, 0.15) },
    DiffDelete = { bg = blend(groups.git_delete, groups.background, 0.15) },
    DiffText = { bg = blend(groups.git_text, groups.background, 0.25) },
    diffAdded = { link = 'DiffAdd' },
    diffChanged = { link = 'DiffChange' },
    diffRemoved = { link = 'DiffDelete' },
    Directory = { fg = p.blue },
    EndOfBuffer = { fg = p.editor_bg },
    ErrorMsg = { fg = p.pink, style = 'bold' },
    FloatBorder = { fg = p.gray3, bg = styles.float_background },
    FloatTitle = { fg = p.gray4 },
    FoldColumn = { fg = p.gray4 },
    Folded = { fg = p.white, bg = groups.panel },
    IncSearch = { fg = p.editor_bg, bg = p.yellow },
    LineNr = { fg = p.gray4 },
    MatchParen = { fg = p.white, bg = p.gray3, style = 'bold' },
    ModeMsg = { fg = p.blue },
    MoreMsg = { fg = p.blue },
    NonText = { fg = p.gray4 },
    Normal = { fg = p.white, bg = styles.background },
    NormalFloat = { fg = p.white, bg = styles.float_background },
    NormalNC = { fg = p.white, bg = styles.nc_background },
    NvimInternalError = { fg = p.white, bg = p.pink },
    Pmenu = { fg = p.light_gray, bg = p.darker_black },
    PmenuSbar = { bg = p.gray3 },
    PmenuSel = { fg = p.white, bg = p.gray1 },
    PmenuThumb = { bg = p.gray3 },
    Question = { fg = p.yellow },
    QuickFixLine = { bg = p.gray1 },
    RedrawDebugClear = { fg = p.white, bg = p.yellow },
    RedrawDebugComposed = { fg = p.white, bg = p.cyan },
    RedrawDebugRecompose = { fg = p.white, bg = p.pink },
    Search = { fg = p.editor_bg, bg = p.yellow },
    SpecialKey = { fg = p.cyan },
    SpellBad = { sp = p.pink, style = 'undercurl' },
    SpellCap = { sp = p.blue, style = 'undercurl' },
    SpellLocal = { sp = p.yellow, style = 'undercurl' },
    SpellRare = { sp = p.blue, style = 'undercurl' },
    SignColumn = { fg = p.white, bg = p.none },
    StatusLine = { fg = p.blue, bg = styles.float_background },
    StatusLineNC = { fg = p.blue, bg = styles.background },
    StatusLineTerm = { link = 'StatusLine' },
    StatusLineTermNC = { link = 'StatusLineNC' },
    TabLine = { fg = p.blue, bg = styles.float_background },
    TabLineFill = { bg = styles.float_background },
    TabLineSel = { fg = p.white, bg = p.gray1 },
    Title = { fg = p.white },
    VertSplit = { fg = groups.border, bg = styles.vert_split },
    Visual = { bg = '#264F78', fg = '#FFFFFF' },
    VisualNOS = { link = 'Visual' },
    WarningMsg = { fg = p.yellow },
    Whitespace = { fg = p.gray4 },
    WildMenu = { link = 'IncSearch' },

    -- Sintaxis
    Constant = { fg = p.white },
    String = { fg = p.cyan },
    Character = { fg = p.pink },
    Number = { fg = p.cyan },
    Boolean = { fg = p.cyan },
    Float = { fg = p.cyan },
    Identifier = { fg = p.white },
    Function = { fg = p.light_blue },
    Statement = { fg = p.white },
    Conditional = { fg = p.cyan },
    Repeat = { fg = p.blue },
    Label = { fg = p.white },
    Operator = { fg = p.dark_blue },
    Keyword = { fg = p.cyan, style = styles.italic },
    Exception = { fg = p.blue },
    PreProc = { fg = p.white },
    Include = { fg = p.cyan },
    Define = { fg = p.cyan },
    Macro = { fg = p.cyan },
    PreCondit = { fg = p.cyan },
    Type = { fg = p.dark_blue },
    StorageClass = { fg = p.cyan },
    Structure = { fg = p.dark_blue },
    Typedef = { fg = p.dark_blue },
    Special = { fg = p.light_blue },
    SpecialChar = { fg = p.pink },
    Tag = { fg = p.white },
    Delimiter = { fg = p.white },
    SpecialComment = { fg = p.light_gray },
    Debug = { fg = p.pink },
    Underlined = { style = 'underline' },
    Bold = { style = 'bold' },
    Italic = { style = styles.italic },
    Error = { fg = p.pink },
    Todo = { fg = p.yellow, bg = p.editor_bg, style = 'bold' },

    -- Markdown
    markdownHeadingDelimiter = { fg = p.gray4, style = 'bold' },
    markdownCode = { fg = p.light_gray },
    markdownCodeBlock = { fg = p.cyan },
    markdownH1 = { fg = groups.headings.h1, style = 'bold' },
    markdownH2 = { fg = groups.headings.h2, style = 'bold' },
    markdownH3 = { fg = groups.headings.h3, style = 'bold' },
    markdownH4 = { fg = groups.headings.h4, style = 'bold' },
    markdownLinkText = { fg = p.blue, style = 'underline' },
    markdownBold = { style = 'bold' },
    markdownItalic = { style = styles.italic },
    markdownUrl = { fg = p.blue, style = 'underline' },
    markdownListMarker = { fg = p.blue },

    -- Diagnosticos
    DiagnosticError = { fg = groups.error },
    DiagnosticWarn = { fg = groups.warn },
    DiagnosticInfo = { fg = groups.info },
    DiagnosticHint = { fg = groups.hint },
    DiagnosticVirtualTextError = { fg = groups.error },
    DiagnosticVirtualTextWarn = { fg = groups.warn },
    DiagnosticVirtualTextInfo = { fg = groups.info },
    DiagnosticVirtualTextHint = { fg = groups.hint },
    DiagnosticUnderlineError = { sp = groups.error, style = 'undercurl' },
    DiagnosticUnderlineWarn = { sp = groups.warn, style = 'undercurl' },
    DiagnosticUnderlineInfo = { sp = groups.info, style = 'undercurl' },
    DiagnosticUnderlineHint = { sp = groups.hint, style = 'undercurl' },
    DiagnosticFloatingError = { fg = groups.error },
    DiagnosticFloatingWarn = { fg = groups.warn },
    DiagnosticFloatingInfo = { fg = groups.info },
    DiagnosticFloatingHint = { fg = groups.hint },
    DiagnosticSignError = { fg = groups.error },
    DiagnosticSignWarn = { fg = groups.warn },
    DiagnosticSignInfo = { fg = groups.info },
    DiagnosticSignHint = { fg = groups.hint },

    -- Treesitter
    ['@annotation'] = { fg = p.purple },
    ['@attribute'] = { fg = p.cyan, style = styles.italic }, -- Atributos en cursiva
    ['@boolean'] = { link = 'Boolean' },
    ['@character'] = { link = 'Character' },
    ['@character.special'] = { fg = p.pink },
    ['@comment'] = { link = 'Comment', style = styles.italic }, -- Los comentarios ya tienen italic en tu configuración base
    ['@conditional'] = { link = 'Conditional' },
    ['@constant'] = { fg = p.white },
    ['@constant.builtin'] = { fg = p.cyan, style = 'bold' }, -- Constantes builtin en negrita
    ['@constant.macro'] = { fg = p.cyan },
    ['@constructor'] = { fg = p.cyan, style = 'bold' }, -- Constructores en negrita
    ['@debug'] = { fg = p.pink },
    ['@define'] = { fg = p.cyan, style = styles.italic }, -- Definiciones en cursiva
    ['@exception'] = { fg = p.pink },
    ['@field'] = { fg = p.blue, style = styles.italic }, -- Campos en cursiva
    ['@float'] = { link = 'Float' },
    ['@function'] = { link = 'Function' }, -- Funciones en negrita (definido en el grupo base)
    ['@function.builtin'] = { fg = p.light_blue, style = 'bold' },
    ['@function.call'] = { fg = p.light_blue, style = 'bold' },
    ['@function.macro'] = { fg = p.light_blue, style = 'bold' },
    ['@include'] = { fg = p.cyan, style = 'bold' }, -- Includes en negrita
    ['@keyword'] = { link = 'Keyword' }, -- Keywords en cursiva (definido en el grupo base)
    ['@keyword.function'] = { fg = p.cyan, style = styles.italic },
    ['@keyword.operator'] = { fg = p.cyan, style = styles.italic },
    ['@keyword.return'] = { fg = p.cyan, style = 'bold' }, -- Returns en negrita
    ['@label'] = { fg = p.blue },
    ['@method'] = { fg = p.light_blue, style = 'bold' }, -- Métodos en negrita
    ['@method.call'] = { fg = p.light_blue, style = 'bold' },
    ['@namespace'] = { fg = p.dark_blue, style = styles.italic }, -- Namespaces en cursiva
    ['@none'] = { fg = p.white },
    ['@number'] = { link = 'Number' },
    ['@operator'] = { link = 'Operator' },
    ['@parameter'] = { fg = p.white, style = styles.italic }, -- Parámetros en cursiva
    ['@parameter.reference'] = { fg = p.white, style = styles.italic },
    ['@property'] = { fg = p.blue, style = styles.italic }, -- Propiedades en cursiva
    ['@punctuation.bracket'] = { fg = p.white },
    ['@punctuation.delimiter'] = { fg = groups.punctuation },
    ['@punctuation.special'] = { fg = groups.punctuation },
    ['@repeat'] = { link = 'Repeat' },
    ['@storageclass'] = { fg = p.cyan, style = styles.italic }, -- Storage classes en cursiva
    ['@string'] = { link = 'String' },
    ['@string.escape'] = { fg = p.pink, style = 'bold' }, -- Escapes en negrita
    ['@string.regex'] = { fg = p.cyan, style = 'bold' }, -- Regex en negrita
    ['@string.special'] = { fg = p.pink },
    ['@symbol'] = { fg = p.cyan },
    ['@tag'] = { fg = p.cyan, style = 'bold' }, -- Tags en negrita
    ['@tag.attribute'] = { fg = p.blue, style = styles.italic },
    ['@tag.delimiter'] = { fg = p.white },
    ['@text'] = { fg = p.white },
    ['@text.danger'] = { fg = p.pink, style = 'bold' }, -- Texto de peligro en negrita
    ['@text.emphasis'] = { style = styles.italic },
    ['@text.environment'] = { fg = p.pink },
    ['@text.environment.name'] = { fg = p.cyan, style = 'bold' }, -- Nombres de entorno en negrita
    ['@text.literal'] = { fg = p.cyan },
    ['@text.math'] = { fg = p.light_blue },
    ['@text.note'] = { fg = p.blue, style = styles.italic }, -- Notas en cursiva
    ['@text.reference'] = { fg = p.blue, style = 'underline' },
    ['@text.strike'] = { style = 'strikethrough' },
    ['@text.strong'] = { style = 'bold' },
    ['@text.title'] = { fg = groups.headings.h1, style = 'bold' },
    ['@text.underline'] = { style = 'underline' },
    ['@text.uri'] = { fg = groups.link, style = 'underline' },
    ['@text.warning'] = { fg = p.yellow, style = 'bold' }, -- Advertencias en negrita
    ['@type'] = { link = 'Type' },
    ['@type.builtin'] = { link = 'Type' },
    ['@type.definition'] = { fg = p.dark_blue, style = styles.italic }, -- Definiciones de tipo en cursiva
    ['@type.qualifier'] = { fg = p.cyan, style = styles.italic }, -- Calificadores de tipo en cursiva
    ['@variable'] = { fg = p.white },
    ['@variable.builtin'] = { fg = p.blue, style = 'bold' }, -- Variables builtin en negrita

    -- LSP
    LspReferenceText = { bg = p.blue },
    LspReferenceRead = { bg = p.blue },
    LspReferenceWrite = { bg = p.blue },
    LspCodeLens = { fg = p.light_gray },
    LspCodeLensSeparator = { fg = p.gray3 },
    LspSignatureActiveParameter = { bg = p.gray1 },

    -- Plugins
    -- nvim-tree
    NvimTreeNormal = { fg = p.white, bg = p.sidebar },
    NvimTreeEndOfBuffer = { fg = p.sidebar, bg = p.sidebar },
    NvimTreeCursorLine = { bg = p.gray2 }, -- Un poco más claro para la selección
    NvimTreeWinSeparator = { fg = p.sidebar, bg = p.sidebar }, -- Bordes integrados
    NvimTreeFolderIcon = { fg = p.blue },
    NvimTreeFolderName = { fg = p.blue },
    NvimTreeOpenedFolderName = { fg = p.light_blue },
    NvimTreeRootFolder = { fg = p.cyan, style = 'bold' },
    NvimTreeGitDirty = { fg = p.yellow },
    NvimTreeGitDeleted = { fg = p.pink },
    NvimTreeGitStaged = { fg = p.cyan },
    NvimTreeGitMerge = { fg = p.purple },
    NvimTreeGitRenamed = { fg = p.cyan },
    NvimTreeGitNew = { fg = p.cyan },
    NvimTreeWindowPicker = { fg = p.editor_bg, bg = p.light_gray },

    -- Telescope
    TelescopeBorder = { fg = p.gray3, bg = p.sidebar },
    TelescopeNormal = { fg = p.light_gray, bg = p.sidebar },
    TelescopeSelection = { fg = p.wite, bg = p.grey3 },
    TelescopeSelectionCaret = { fg = p.pink },
    TelescopeMultiSelection = { fg = p.purple },
    TelescopeMatching = { fg = p.cyan },
    TelescopePromptPrefix = { fg = p.blue, bg = p.sidebar },
    TelescopePromptBorder = { fg = p.gray3, bg = p.sidebar },
    TelescopePromptNormal = { fg = p.white, bg = p.sidebar },
    TelescopeResultsBorder = { fg = p.gray3, bg = p.darker_black },
    TelescopeResultsNormal = { fg = p.light_gray, bg = p.darker_black },
    TelescopePreviewBorder = { fg = p.gray3, bg = p.darker_black },
    TelescopePreviewNormal = { fg = p.light_gray, bg = p.darker_black },
    TelescopePreviewTitle = { fg = p.editor_bg, bg = p.blue },
    TelescopePromptTitle = { fg = p.editor_bg, bg = p.blue },
    TelescopeResultsTitle = { fg = p.darker_black, bg = p.darker_black },

    -- CMP
    CmpItemAbbr = { fg = p.white }, -- Texto normal
    CmpItemAbbrMatch = { fg = p.cyan, style = 'bold' }, -- Coincidencias
    CmpItemAbbrDeprecated = { fg = p.pink, style = 'strikethrough' },
    CmpItemAbbrMatchFuzzy = { fg = p.cyan, style = 'bold' }, -- Coincidencias difusas
    CmpItemKind = { fg = p.blue },
    CmpItemKindClass = { fg = p.yellow },
    CmpItemKindColor = { fg = p.cyan },
    CmpItemKindConstant = { fg = p.cyan },
    CmpItemKindConstructor = { fg = p.cyan },
    CmpItemKindEnum = { fg = p.purple },
    CmpItemKindEnumMember = { fg = p.blue },
    CmpItemKindEvent = { fg = p.purple },
    CmpItemKindField = { fg = p.cyan },
    CmpItemKindFile = { fg = p.blue },
    CmpItemKindFolder = { fg = p.blue },
    CmpItemKindFunction = { fg = p.blue }, -- Funciones (azul claro)
    CmpItemKindInterface = { fg = p.light_blue }, -- Interfaces (azul brillante)
    CmpItemKindKeyword = { fg = p.cyan },
    CmpItemKindMethod = { fg = p.purple }, -- Métodos (rosa)
    CmpItemKindModule = { fg = p.blue },
    CmpItemKindOperator = { fg = p.dark_blue },
    CmpItemKindProperty = { fg = p.blue },
    CmpItemKindReference = { fg = p.blue },
    CmpItemKindSnippet = { fg = p.yellow },
    CmpItemKindStruct = { fg = p.purple },
    CmpItemKindText = { fg = p.light_gray },
    CmpItemKindTypeParameter = { fg = p.dark_blue },
    CmpItemKindUnit = { fg = p.purple },
    CmpItemKindValue = { fg = p.cyan },
    CmpItemKindVariable = { fg = p.white }, -- Variables (blanco)
    CmpItemMenu = { fg = p.dark_gray, italic = true }, -- Tipo de item ("Function", "Variable")
    CmpItemSel = { bg = '#303030' }, -- Fondo del item seleccionado
    -- CmpDocBorder = { '#303030', bg = '#090909' }, -- Borde documentación
    CmpDocumentation = { bg = '#090909' },
    -- CmpItemBorder = { fg = '#303030', bg = '#090909' }, -- Borde delgado oscuro
    CmpDocumentationBorder = { fg = '#090909', bg = '#090909' }, -- Mismo estilo

    -- GitSigns
    GitSignsAdd = { fg = groups.git_add },
    GitSignsChange = { fg = groups.git_change },
    GitSignsDelete = { fg = groups.git_delete },
    GitSignsAddNr = { fg = groups.git_add },
    GitSignsChangeNr = { fg = groups.git_change },
    GitSignsDeleteNr = { fg = groups.git_delete },
    GitSignsAddLn = { bg = blend(groups.git_add, groups.background, 0.2) },
    GitSignsChangeLn = { bg = blend(groups.git_change, groups.background, 0.2) },

    -- IndentBlankline
    IndentBlanklineChar = { fg = p.gray1 },
    IndentBlanklineContextChar = { fg = p.yellow, gui = 'nocombine' },
    IndentBlanklineContextStart = { sp = p.yellow, style = 'underline' },
    IndentBlanklineSpaceChar = { link = 'Whitespace' },
    IndentBlanklineSpaceCharBlankline = { link = 'Whitespace' },

    -- Rainbow
    rainbowcol1 = { fg = p.blue },
    rainbowcol2 = { fg = p.cyan },
    rainbowcol3 = { fg = p.yellow },
    rainbowcol4 = { fg = p.light_blue },
    rainbowcol5 = { fg = p.cyan },
    rainbowcol6 = { fg = p.pink },
    rainbowcol7 = { fg = p.blue },

    -- Notify
    NotifyINFOBorder = { fg = p.cyan },
    NotifyINFOTitle = { link = 'NotifyINFOBorder' },
    NotifyINFOIcon = { link = 'NotifyINFOBorder' },
    NotifyWARNBorder = { fg = p.yellow },
    NotifyWARNTitle = { link = 'NotifyWARNBorder' },
    NotifyWARNIcon = { link = 'NotifyWARNBorder' },
    NotifyDEBUGBorder = { fg = p.blue },
    NotifyDEBUGTitle = { link = 'NotifyDEBUGBorder' },
    NotifyDEBUGIcon = { link = 'NotifyDEBUGBorder' },
    NotifyTRACEBorder = { fg = p.blue },
    NotifyTRACETitle = { link = 'NotifyTRACEBorder' },
    NotifyTRACEIcon = { link = 'NotifyTRACEBorder' },
    NotifyERRORBorder = { fg = p.pink },
    NotifyERRORTitle = { link = 'NotifyERRORBorder' },
    NotifyERRORIcon = { link = 'NotifyERRORBorder' },
  }

  -- Terminal colors
  vim.g.terminal_color_0 = p.editor_bg
  vim.g.terminal_color_8 = p.gray1
  vim.g.terminal_color_1 = p.pink
  vim.g.terminal_color_9 = p.pink
  vim.g.terminal_color_2 = p.cyan
  vim.g.terminal_color_10 = p.cyan
  vim.g.terminal_color_3 = p.yellow
  vim.g.terminal_color_11 = p.yellow
  vim.g.terminal_color_4 = p.light_blue
  vim.g.terminal_color_12 = p.blue
  vim.g.terminal_color_5 = p.purple
  vim.g.terminal_color_13 = p.purple
  vim.g.terminal_color_6 = p.light_blue
  vim.g.terminal_color_14 = p.blue
  vim.g.terminal_color_7 = p.white
  vim.g.terminal_color_15 = p.white

  return theme
end

return M
