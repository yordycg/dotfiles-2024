-- lua/plugins/database.lua
-- Database management with vim-dadbod

-- 1. Configuration (vim.g variables for vim-dadbod-ui)
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_navigation = 1
vim.g.db_ui_win_width = 35
vim.g.db_ui_auto_execute_table_helpers = 1

-- 2. Keymaps
local set = vim.keymap.set

-- Toggle DBUI
set("n", "<leader>du", ":DBUIToggle<CR>", { desc = "Toggle DBUI" })
set("n", "<leader>df", ":DBUIFindBuffer<CR>", { desc = "Find DB Buffer" })
set("n", "<leader>dr", ":DBUIRenameBuffer<CR>", { desc = "Rename DB Buffer" })
set("n", "<leader>dl", ":DBUILastQueryInfo<CR>", { desc = "Last Query Info" })

-- 3. SQL Specific (for buffers with .sql extension)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    -- Map <leader>S to execute query under cursor or selection
    set("n", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })
    set("v", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Selection" })
    
    -- Integration with blink.cmp (Completion)
    -- This requires dadbod-completion to be added as a source if you used nvim-cmp, 
    -- but for blink.cmp it works slightly differently.
  end,
})

return {}
