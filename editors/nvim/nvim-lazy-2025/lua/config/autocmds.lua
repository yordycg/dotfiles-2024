-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local api = vim.api

-- Don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Highlight on yank
local highlight_group = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Transparent
-- Este autocomando se ejecuta después de que se carga el esquema de colores
-- api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*", -- Aplica a cualquier esquema de colores
--   callback = function()
--     -- Define los grupos de resaltado que quieres hacer transparentes
--     local groups_to_transparent = {
--       "Normal", -- Fondo del editor principal
--       "Float", -- Ventanas flotantes genéricas
--       "NormalFloat", -- Fondo de ventanas flotantes
--       "Pmenu", -- Menú flotante de autocompletado
--       "NeoTreeNormal", -- Sidebar de Neo-tree
--       -- "NvimTreeNormal", -- Si usas NvimTree en lugar de Neo-tree, descomenta esta línea
--       "FoldColumn", -- Columna de plegado de código
--       "SignColumn", -- Columna de signos (diagnósticos, git)
--       "LineNr", -- Número de línea
--       "CursorLineNr", -- Número de línea actual
--       -- "StatusLine",     -- Si quieres la barra de estado transparente
--       -- "StatusLineNC",   -- Si quieres la barra de estado no-actual transparente
--       "BufferLineBackground", -- Si usas bufferline
--       "BufferLineFill", -- Si usas bufferline
--       -- "TabLine",          -- Si usas tabs
--       -- "TabLineFill",      -- Si usas tabs
--       -- "TabLineSel",       -- Si usas tabs
--       -- Puedes añadir más grupos según tus plugins
--       -- "TelescopeNormal",  -- Si usas Telescope
--       -- "TelescopeBorder",  -- Si usas Telescope
--       "LspInfoBorder", -- Ejemplo para una ventana de información LSP
--     }
--
--     -- Itera sobre los grupos y establece su fondo a none
--     for _, group in ipairs(groups_to_transparent) do
--       -- Usamos bg = "none". En nvim_set_hl, 'bg' funciona tanto para TUI como GUI.
--       pcall(vim.api.nvim_set_hl, 0, group, { bg = "none" })
--       -- También puedes intentar con guibg = "none" si bg no funciona en tu terminal/GUI
--       -- pcall(vim.api.nvim_set_hl, 0, group, { guibg = "none" })
--     end
--
--     -- Opcional: Algunos esquemas de colores pueden establecer el guibg global en el grupo 'Normal'.
--     -- Asegurarse de que Normal siga siendo transparente.
--     -- pcall(vim.api.nvim_set_hl, 0, "Normal", { bg = "none" })
--   end,
-- })
