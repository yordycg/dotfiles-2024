-- lua/themes/unokai.lua
local status, monokai = pcall(require, "monokai")
if not status then return end

monokai.setup({
  palette = monokai.classic, -- Classic monokai style
  custom_hl_groups = {
    Normal = { bg = "none" },
    NormalNC = { bg = "none" },
  },
})

vim.cmd([[colorscheme monokai]])
