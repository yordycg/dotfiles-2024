-- lua/plugins/linting.lua
-- Nvim-lint: Lightweight linting that complements LSP
local status, lint = pcall(require, "lint")
if not status then return end

local linter_base = vim.fn.expand("$HOME/workspace/infra/dotfiles-2024/os/cross-platform/linters")

lint.linters_by_ft = {
  lua = { "luacheck" },
  python = { "ruff" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  bash = { "shellcheck" },
  cpp = { "cpplint" },
}

-- Global Linter Configs Overrides
lint.linters.luacheck = {
  cmd = "luacheck",
  stdin = true,
  args = {
    "--globals",
    "vim",
    "--config",
    linter_base .. "/.luacheckrc",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
  },
  stream = "stdout",
  ignore_exitcode = true,
  parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
    source = "luacheck",
  }),
}

-- Create an autocmd to trigger linting on relevant events
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- Manual lint trigger
vim.keymap.set("n", "<leader>l", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
