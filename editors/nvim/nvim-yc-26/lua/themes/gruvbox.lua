-- lua/themes/gruvbox.lua
local status, gruvbox = pcall(require, "gruvbox")
if not status then return end

gruvbox.setup({
  transparent_mode = true,
})

vim.cmd([[colorscheme gruvbox]])
