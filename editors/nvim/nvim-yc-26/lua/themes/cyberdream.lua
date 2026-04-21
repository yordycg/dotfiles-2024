-- lua/themes/cyberdream.lua
local status, cyberdream = pcall(require, "cyberdream")
if not status then return end

cyberdream.setup({
  transparent = true,
  italic_comments = true,
})

vim.cmd([[colorscheme cyberdream]])
