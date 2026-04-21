-- lua/themes/nord.lua
local status, nord = pcall(require, "nord")
if not status then return end

nord.setup({
  transparent = true,
})

vim.cmd([[colorscheme nord]])
