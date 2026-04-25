-- lua/plugins/multicursor.lua
-- Multiple cursors like VS Code

-- Configuration for vim-visual-multi
-- We set global variables because this is a Vimscript plugin
vim.g.VM_leader = "\\"
vim.g.VM_maps = {
  ["Find Under"] = "<C-n>",
  ["Find Subword Under"] = "<C-n>",
}

-- Documentation:
-- Ctrl-n: Select word under cursor
-- Ctrl-Down/Up: Create cursor above/below
-- Esc: Exit VM mode

return {}
