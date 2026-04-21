-- lua/plugins/treesitter.lua
-- Better syntax highlighting and code understanding
local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then return end

ts.setup({
  -- Install common parsers automatically
  ensure_installed = { 
    "lua", "vim", "vimdoc", "python", "javascript", 
    "typescript", "bash", "markdown", "markdown_inline",
    "json", "yaml", "html", "css" 
  },
  highlight = { enable = true },
  indent = { enable = true },
})
