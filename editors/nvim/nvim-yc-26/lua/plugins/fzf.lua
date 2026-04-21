-- lua/plugins/fzf.lua
-- Fast and extensible fuzzy finder using fzf binary
local status, fzf = pcall(require, "fzf-lua")
if not status then return end

fzf.setup({
  -- Ensure it uses your system theme/colors
  winopts = {
    height = 0.85,
    width = 0.80,
    preview = {
      horizontal = "right:50%",
    },
  },
})

-- Mappings (Coherent with your 2026 setup)
local set = vim.keymap.set
set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
set("n", "<leader>fg", fzf.live_grep, { desc = "Live Grep" })
set("n", "<leader>fb", fzf.buffers, { desc = "Find Buffers" })
set("n", "<leader>fh", fzf.help_tags, { desc = "Find Help" })
set("n", "<leader>fr", fzf.resume, { desc = "Resume last search" })
