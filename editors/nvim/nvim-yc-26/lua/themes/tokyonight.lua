-- lua/themes/tokyonight.lua
local status, tokyonight = pcall(require, "tokyonight")
if not status then return end

tokyonight.setup({
  style = "moon", -- "storm", "moon", "night", "day"
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
})

vim.cmd([[colorscheme tokyonight-moon]])
