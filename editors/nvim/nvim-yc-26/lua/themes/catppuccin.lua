-- lua/themes/catppuccin.lua
local status, catppuccin = pcall(require, "catppuccin")
if not status then return end

catppuccin.setup({
  flavour = "mocha", -- "latte", "frappe", "macchiato", "mocha"
  transparent_background = true,
  integrations = {
    fidget = true,
    fzf = true,
    gitsigns = true,
    mini = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    oil = true,
    treesitter = true,
  },
})

vim.cmd([[colorscheme catppuccin-mocha]])
