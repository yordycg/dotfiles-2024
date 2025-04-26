-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Essentials
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>w", "<CMD> w <CR>", opts) -- Save file
map("n", "<leader>sn", "<CMD>noautocmd w <CR>", opts) -- Save file without auto-formatting
map("n", "<leader>q", "<CMD> q <CR>", opts) -- Quit file
map("i", "jk", "<ESC>") -- Exit mode insert
map("i", "jj", "<ESC>") -- Exit mode insert
map("n", "<CR>", "ciw", opts) -- Map 'enter' to ciw
map("n", "<BS>", "ci", opts) -- Map 'backspace' to ci
map("n", "<C-a>", "ggVG", opts) -- Select all in normal mode
map("v", "<C-c>", '"+y', opts) -- Copy in visual mode
map("v", "<C-x>", '"+d', opts) -- Cut in visual mode
map({ "n", "v" }, "<C-v>", '"+p', opts) -- Paste in normal and visual mode
map("n", "<leader>lw", "<CMD>set wrap!<CR>", opts) -- Toggle line wrapping
map("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<CR>", { silent = true }) -- Split line with X
map("n", "x", '"_x', opts) -- Delete single character without copying into register
map("n", "YY", "va{Vy", opts) -- Copy everything BETWEEN { and } including the brackets

-- Go to END or START
map("n", "<leader>[", "<S-$>%", { noremap = true, desc = "Move to end {([])}" })

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Move line on the screen rather than by line in the file
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Keep last yanked when pasting
map("v", "p", '"_dP', opts)
map("v", "P", '"_dP', opts)

-- Move to start/end of line
map({ "n", "x", "o" }, "H", "^", opts)
map({ "n", "x", "o" }, "L", "g_", opts)

-- Remap for dealing with visual line wraps
map("n", "j", "v:count == 0 ? 'gj' : 'J'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : 'K'", { expr = true })

-- Indent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Vertical scroll and center | keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
map("n", "n", "nzzv", opts) -- Go to NEXT match
map("n", "N", "Nzzv", opts) -- Go to PREVIOUS match
map("n", "*", "*zzv", opts) -- Search cursor word FORWARD
map("n", "#", "#zzv", opts) -- Search cursor word BACKWARD (?)
map("n", "g#", "g#zzv", opts) -- Search cursor partial word FORWARD (?)
map("n", "g", "gzzv", opts) -- Search cursor partial word BACKWARD (?)

-- LiveServer
map("n", "<leader>ls", ":LiveServerStart<CR>", { desc = "Start Live Server" })
map("n", "<leader>lc", ":LiveServerStop<CR>", { desc = "Stop Live Server" })
map("n", "<leader>lr", ":LiveServerRestart<CR>", { desc = "Restart Live Server" })

-- Markdown Preview
map("n", "<leader>m", "MarkdownPreview", { noremap = true })
map("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true })
map("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { noremap = true })
map("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { noremap = true })

-- Refactoring
map({ "x", "n" }, "<leader>r", "Refactor")
map("x", "<leader>re", ":Refactor extract ")
map("x", "<leader>rf", ":Refactor extract_to_file ")
map("x", "<leader>rv", ":Refactor extract_var ")
map({ "x", "n" }, "<leader>ri", ":Refactor inline_var")
map("n", "<leader>rI", ":Refactor inline_func")
map("n", "<leader>rb", ":Refactor extract_block")
map("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- ToggleTerm
map("n", "<leader>T", "ToggleTerm", { noremap = true, desc = "ToggleTerm" })
map("n", "<leader>Tt", ":ToggleTerm<CR>", { noremap = true, desc = "Toggle Terminal (default)" })
map("n", "<leader>Tr", ":ToggleTerm direction=tab<CR>", { noremap = true, desc = "Toggle Terminal (tab)" })
map("n", "<leader>Tf", ":ToggleTerm direction=float<CR>", { noremap = true, desc = "Toggle Terminal (float)" })
map(
  "n",
  "<leader>Th",
  ":ToggleTerm direction=horizontal<CR>",
  { noremap = true, desc = "Toggle Terminal (horizontal)" }
)
map("n", "<leader>Tv", ":ToggleTerm direction=vertical<CR>", { noremap = true, desc = "Toggle Terminal (vertical)" })

-- TODO: agregar commentarios

-- Run Files
-- map("n", "<leader>j", "Execute Files", { noremap = true })
-- Python files
-- map(
--  "n",
--   "<leader>jp",
--   ":w | :TermExec cmd='python3 \"%\"' size=50 direction=tab go_back=0<CR>",
--   { noremap = true, desc = "Run Python File" }
-- )
-- C++ files
-- map(
--   "n",
--   "<leader>jr",
--  ":w | :TermExec cmd='cr \"%\"' size=50 direction=tab go_back=0<CR>",
--   { noremap = true, desc = "Compile and Run C++ File" }
-- )
-- C++ files with Debug
-- map(
--   "n",
--   "<leader>jd",
--   ":w | :TermExec cmd='cr \"%\" -d' size=50 direction=tab go_back=0<CR>",
--   { noremap = true, desc = "Compile and Run C++ File with Debug" }
-- )
