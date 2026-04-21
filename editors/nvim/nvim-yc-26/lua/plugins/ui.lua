-- lua/plugins/ui.lua
-- Fidget: Visual feedback for LSP progress and notifications
local status, fidget = pcall(require, "fidget")
if not status then return end

fidget.setup({
  notification = {
    window = {
      winblend = 0, -- Transparent background
    },
  },
})
