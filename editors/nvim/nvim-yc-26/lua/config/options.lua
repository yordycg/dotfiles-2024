-- lua/config/options.lua
local opt = vim.opt

-- === General ===
opt.termguicolors = true
opt.encoding = "utf-8"
opt.mouse = "a"
opt.clipboard:append("unnamedplus")
opt.updatetime = 250 -- Faster response for LSP and Git signs
opt.timeoutlen = 300 -- Faster leader key response

-- === Line Numbers ===
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes" -- Always show signcolumn to prevent layout shifts

-- === Indentation ===
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- === Search ===
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- === UI & UX ===
opt.cursorline = true
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.wrap = false
opt.splitbelow = true
opt.splitright = true
opt.showmode = false -- We'll use our own statusline
opt.fillchars = { eob = " " } -- Clean end-of-buffer lines
opt.pumheight = 10 -- Max items in popup menu
opt.laststatus = 3 -- Global statusline (cleaner look with splits)
opt.smoothscroll = true -- Smooth scrolling for wrapped lines
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

-- === List Characters (Whitespace visualization) ===
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- === Undo & Persistence ===
opt.undofile = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- === Folds (Treesitter powered) ===
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
