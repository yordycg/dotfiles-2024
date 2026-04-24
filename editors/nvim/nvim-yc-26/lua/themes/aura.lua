-- lua/themes/aura.lua
-- Official Aura Theme (Dalton Menezes)

vim.cmd([[colorscheme aura-dark]])

-- Force transparency
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
