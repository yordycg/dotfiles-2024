-- lua/plugins/mason-tools.lua
-- Automation for LSP, Formatter and Linter installations
local status, mason_tool_installer = pcall(require, "mason-tool-installer")
if not status then return end

mason_tool_installer.setup({
  ensure_installed = {
    -- === LSP Servers ===
    "typescript-language-server", 
    "html-lsp",
    "css-lsp",
    "tailwindcss-language-server",
    "pyright",
    "ruff",
    "clangd",
    "omnisharp",
    "sqls",
    "lemminx", 
    "bash-language-server",
    "lua-language-server",
    "dockerfile-language-server",
    "json-lsp",
    "yaml-language-server",
    "kotlin-language-server",

    -- === Formatters (for Conform) ===
    "black",         
    "isort",         
    "prettierd",     
    "clang-format",  
    "stylua",        
    "shfmt",         
    "sql-formatter", 
    "xmlformatter",  

    -- === Linters (for nvim-lint) ===
    "eslint_d",
    "shellcheck",
  },

  auto_update = true,
  run_on_start = true,
  start_delay = 3000, 
})
