-- lua/plugins/ui.lua
-- Visual enhancements and UI helpers (Fidget & Which-Key)

-- 1. Fidget: LSP Progress UI
local status_fidget, fidget = pcall(require, "fidget")
if status_fidget then
  fidget.setup({
    notification = { window = { winblend = 0 } }
  })
end

-- 2. Which-Key: Keymap documentation
local status_wk, whichkey = pcall(require, "which-key")
if not status_wk then return end

whichkey.setup({
  preset = "modern",
  spec = {
    -- Leader Groups
    { "<leader>a", icon = "󰛖 ", desc = "Toggle Symbols (Aerial)" },
    { "<leader>b", group = "Buffers", icon = "󰓩 " },
    { "<leader>d", group = "Database", icon = "󰆼 " },
    { "<leader>e", icon = "󰙅 ", desc = "Explorer (Neo-tree)" },
    { "<leader>f", group = "Find / FZF", icon = " " },
    { "<leader>h", group = "Git Hunks", icon = "󰊢 " },
    { "<leader>r", group = "Rename/Refactor", icon = "󰑕 " },
    { "<leader>s", group = "Splits", icon = "󰤼 " },
    { "<leader>t", group = "Terminal", icon = "󰞷 " },
    { "<leader>u", group = "UI / Toggles", icon = "󰂓 " },
    { "<leader>y", group = "Yank (Copy)", icon = "󰆏 " },
    
    -- LSP & Navigation Groups
    { "g", group = "Go to / LSP", icon = "󰒕 " },
    { "gp", group = "Peek (Glance)", icon = "󰛖 " },
    { "[", group = "Previous", icon = "󰒮 " },
    { "]", group = "Next", icon = "󰒭 " },
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
