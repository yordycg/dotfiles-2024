-- lua/themes/onedark.lua
local status, onedark = pcall(require, "onedark")
if not status then return end

onedark.setup({
  style = "darker", -- "dark", "darker", "cool", "deep", "warm", "warmer"
  transparent = true,
})

vim.cmd([[colorscheme onedark]])
