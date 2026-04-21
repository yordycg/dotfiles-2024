-- lua/themes/rose-pine.lua
local status, rose_pine = pcall(require, "rose-pine")
if not status then return end

rose_pine.setup({
  variant = "moon", -- "main", "moon", "dawn"
  styles = {
    transparency = true,
  },
})

vim.cmd([[colorscheme rose-pine]])
