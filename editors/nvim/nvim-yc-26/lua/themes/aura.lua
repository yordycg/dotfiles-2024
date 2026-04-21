-- lua/themes/aura.lua
-- Aura needs a manual set for transparency
local status, aura = pcall(require, "aura")

vim.cmd([[colorscheme aura-soft-dark-vivid]])
-- Force transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
