-- lua/plugins/formatting.lua
-- Conform.nvim: Fast, asynchronous formatting for almost any language
local status, conform = pcall(require, "conform")
if not status then return end

local linter_base = vim.fn.expand("$HOME/workspace/repos/dotfiles-2024/os/cross-platform/linters")

conform.setup({
  formatters_by_ft = {
    -- Web Development
    lua = { "stylua" },
    python = { "isort", "black" }, -- Sort imports first, then format
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    -- Systems & Others
    c = { "clang-format" },
    cpp = { "clang-format" },
    sh = { "shfmt" },
    sql = { "sql_formatter" },
    xml = { "xmlformatter" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
  },

  formatters = {
    stylua = {
      prepend_args = { "--config-path", linter_base .. "/.stylua.toml" },
    },
    ["clang-format"] = {
      prepend_args = { "--style=file:" .. linter_base .. "/.clang-format" },
    },
  },

  -- Format on save behavior
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- Manual format command
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range" })
