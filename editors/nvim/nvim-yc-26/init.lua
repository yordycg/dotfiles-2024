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

-- Set leader before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.keymaps")
require("config.options")
require("config.transparency")

-- 2. Plugin Management (Native vim.pack - Neovim 0.11+)
-- This is the "new packer" style for native plugin management
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
  "https://github.com/daltonmenezes/aura-theme",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/folke/which-key.nvim",
  
  -- Foundation & Dependencies
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/echasnovski/mini.nvim",
  
  -- Navigation & Files
  "https://github.com/stevearc/aerial.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  
  -- LSP, Completion & Tools
  "https://github.com/mg979/vim-visual-multi",
  "https://github.com/dnlhc/glance.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v0.*" },
  
  -- Formatting & Linting
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  
  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",

  -- Markdown Rendering (YC-26 Workflow)
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",

  -- Database Management (YC-26 Workflow)
  "https://github.com/ellisonleao/dotenv.nvim",
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
})

-- 2.1 Filetype Detection & Overrides
-- Ensure .html files are treated as htmldjango for proper syntax and LSP (Emmet)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html",
  callback = function()
    vim.bo.filetype = "htmldjango"
  end,
})

-- 3. Load Plugin Configurations
require("plugins.theme")
require("plugins.treesitter")
require("plugins.autotag")
require("plugins.mini")
require("plugins.ui") -- Fidget & Which-Key
require("plugins.terminal")
require("plugins.oil")
require("plugins.aerial")
require("plugins.neo-tree")
require("plugins.fzf")
require("plugins.lsp")
require("plugins.mason-tools")
require("plugins.completion")
require("plugins.formatting")
require("plugins.linting")
require("plugins.git")
require("plugins.markdown")
require("plugins.database")
require("plugins.glance")
require("plugins.multicursor")
