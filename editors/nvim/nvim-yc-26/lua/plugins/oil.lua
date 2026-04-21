-- lua/plugins/oil.lua
-- Edit the filesystem like a normal buffer
local status, oil = pcall(require, "oil")
if not status then return end

oil.setup({
  default_file_explorer = true,
  columns = { "icon" },
  view_options = {
    show_hidden = true,
  },
})

-- Open Oil with <leader>- (Standard mapping in the community)
vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
