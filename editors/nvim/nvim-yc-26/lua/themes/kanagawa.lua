-- lua/themes/kanagawa.lua
local status, kanagawa = pcall(require, "kanagawa")
if not status then return end

kanagawa.setup({
  transparent = true,
  theme = "wave", -- "wave", "dragon", "lotus"
})

vim.cmd([[colorscheme kanagawa]])
