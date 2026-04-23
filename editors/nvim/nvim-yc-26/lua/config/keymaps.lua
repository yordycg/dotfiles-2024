-- lua/config/keymaps.lua
local set = vim.keymap.set

-- === Leader Keys ===
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- === Navigation (General) ===
-- Better movement in wrapped lines
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down (wrap-aware)" })
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Search centered
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- Exit insert mode
set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
set("i", "kk", "<Esc>", { desc = "Exit insert mode" })

-- Clear search highlights
set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- === Window Management ===
-- Move between windows
set("n", "<C-h>", "<C-w>h", { desc = "Go to Left window" })
set("n", "<C-j>", "<C-w>j", { desc = "Go to Bottom window" })
set("n", "<C-k>", "<C-w>k", { desc = "Go to Top window" })
set("n", "<C-l>", "<C-w>l", { desc = "Go to Right window" })

-- Resize windows
set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Split management
set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split Vertically" })
set("n", "<leader>sh", ":split<CR>", { desc = "Split Horizontally" })

-- === Buffer Management ===
-- Navigation (The YC-26 Style + Standard)
set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
set("n", "<leader>bp", ":bprevious<CR>", { desc = "Prev buffer" })
set("n", "[b", ":bprevious<CR>", { desc = "Prev buffer (standard)" })
set("n", "]b", ":bnext<CR>", { desc = "Next buffer (standard)" })
set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete current buffer" })

-- === Line / Block Manipulation ===
-- Move lines up/down
set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
set("v", "<A-j>", ":m '>+1<CR>gv==gv", { desc = "Move selection down" })
set("v", "<A-k>", ":m '<-2<CR>gv==gv", { desc = "Move selection up" })

-- Better indenting in visual mode
set("v", "<", "<gv", { desc = "Indent Left" })
set("v", ">", ">gv", { desc = "Indent Right" })

-- Join lines and keep cursor position
set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- === Clipboard & Utilities ===
-- Select All
set("n", "<C-a>", "ggVG", { desc = "Select all text" })

-- Copy All to Clipboard
set("n", "<leader>ya", ":%y+<CR>", { desc = "Copy all text to clipboard" })

-- Paste without overwriting register
set("x", "<leader>p", '"_dP', { desc = "Paste (no yank)" })

-- Delete without overwriting register
set({"n", "v"}, "<leader>x", '"_d', { desc = "Delete (no yank)" })

-- Copy full file path (YC-26 Special)
set("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied path:", path)
end, { desc = "Copy absolute path" })

-- Toggle diagnostics (YC-26 Special)
set("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle Diagnostics" })
