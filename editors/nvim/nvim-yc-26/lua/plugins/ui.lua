-- lua/plugins/ui.lua
-- Visual enhancements and UI helpers (Fidget & Which-Key)

-- 1. Fidget: LSP Progress UI
local status_fidget, fidget = pcall(require, "fidget")
if status_fidget then
  fidget.setup({})
end

-- 2. Which-Key: Keymap documentation
local status_wk, whichkey = pcall(require, "which-key")
if not status_wk then return end

whichkey.setup({
  preset = "modern",
  spec = {
    { "<leader>f", group = "Find / Files" },
    { "<leader>b", group = "Buffers" },
    { "<leader>h", group = "Git Hunks" },
    { "<leader>t", group = "Terminal" },
    { "<leader>u", group = "UI / Toggles" },
    { "<leader>s", group = "Splits" },
    { "<leader>d", group = "Database Management" },
    { "g", group = "Go to / LSP Navigation" },
    { "[", group = "Prev / Diagnostics" },
    { "]", group = "Next / Diagnostics" },
  },
  win = {
    border = "rounded",
    padding = { 1, 2 },
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
})

return {}
