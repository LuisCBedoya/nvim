local variants = {
  main = {
    -- Fondos
    editor_bg = '#1b1e28', -- editor.background
    sidebar = '#090909',
    status_bar = '#121212',
    black1 = '#0f0f0f',
    darker_black = '#080808',
    darker_black1 = '#171922', -- activityBar.background
    darkest_black = '#0f0f0f', -- input.background

    -- Grises
    gray1 = '#121212', -- editorIndentGuide.background
    gray2 = '#181818', -- editor.selectionBackground
    gray3 = '#303030', -- scrollbarSlider.background
    gray4 = '#444444', -- sideBar.foreground
    gray5 = '#888888', -- editor.foreground

    -- Colores funcionales
    cyan = '#5DE4c7', -- gitDecoration.renamedResourceForeground
    light_blue = '#89ddff', -- terminal.ansiBrightBlue
    blue = '#ADD7FF', -- textLink.foreground
    dark_blue = '#91B4D5', -- entity.name
    purple = '#f087bd', -- terminal.ansiMagenta
    pink = '#d0679d', -- errorForeground
    yellow = '#fffac2', -- editorWarning.foreground

    -- Texto
    white = '#e4f0fb', -- editor.foreground
    light_gray = '#a6accd', -- editor.foreground
    dark_gray = '#767c9d', -- comment

    -- Git
    git_add = '#5fb3a1', -- gitDecoration.addedResourceForeground
    git_change = '#ADD7FF', -- gitDecoration.modifiedResourceForeground
    git_delete = '#d0679d', -- gitDecoration.deletedResourceForeground
    git_ignore = '#767c9d70', -- gitDecoration.ignoredResourceForeground

    none = 'NONE',
  },
}

local palette = {}

palette = variants.main

-- if vim.o.background == "light" then
-- 	palette = variants.main
-- else
-- 	palette = variants[(vim.g.poimandres_variant == "storm" and "storm") or "main"]
-- end

return palette
