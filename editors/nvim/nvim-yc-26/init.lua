-- init.lua
-- Main entry point for nvim-yc-26

-- 1. Base Configuration
-- Setup fnm/node path so Mason can find npm
if vim.fn.executable("fnm") == 1 then
  local fnm_output = vim.fn.system("fnm env --use-on-cd --shell bash")
  for line in fnm_output:gmatch("[^\r\n]+") do
    local path = line:match('export PATH="([^"]+)"')
    if path then
      vim.env.PATH = path .. ":" .. vim.env.PATH
    end
  end
end

require("config.keymaps") -- Leader must be first
require("config.options")
require("config.transparency")

-- 2. Plugin Management (Native vim.pack)
-- Using the experimental but powerful native package management
vim.pack.add({
  -- Core UI & Themes
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/shaunsingh/nord.nvim",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/scottmckendry/cyberdream.nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/sainnhe/everforest",
  "https://github.com/navarasu/onedark.nvim",
  "https://github.com/tanvirtin/monokai.nvim",
  "https://github.com/baliestri/aura-theme",
  "https://github.com/j-hui/fidget.nvim",
  
  -- Foundation
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "https://github.com/echasnovski/mini.nvim",
  
  -- Navigation & Files
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/stevearc/oil.nvim",
  
  -- LSP, Completion & Tools
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v0.*" },
  
  -- Formatting & Linting
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  
  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",
})

-- 3. Load Plugin Configurations
require("plugins.theme")
require("plugins.treesitter")
require("plugins.mini")
require("plugins.ui") -- Fidget & others
require("plugins.oil")
require("plugins.fzf")
require("plugins.lsp")
require("plugins.mason-tools")
require("plugins.completion")
require("plugins.formatting")
require("plugins.linting")
require("plugins.git")
