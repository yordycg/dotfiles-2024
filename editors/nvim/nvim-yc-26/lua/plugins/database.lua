-- lua/plugins/database.lua
-- Database management with vim-dadbod & Docker Bridge (via ~/.local/bin symlinks)

-- 1. Configuration
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_navigation = 1
vim.g.db_ui_win_width = 35

-- 2. Smart Connection Builder
local function setup_dadbod_connections()
  local env_file = vim.fn.getcwd() .. "/.env"
  local env = {}
  
  if vim.fn.filereadable(env_file) == 1 then
    for line in io.lines(env_file) do
      local k, v = line:match("^([%w_]+)=([%w%d%p%.%-_]+)")
      if k and v then 
        env[k] = v 
        vim.fn.setenv(k, v)
      end
    end
  end

  local db_type = env.DB_TYPE or ""
  local db_name = env.DB_NAME or "dev_db"
  local db_user = env.DB_USER or "admin"
  local db_pass = env.DB_PASS or "password"
  local db_port = env.DB_PORT
  local db_host = "localhost"

  -- Smart detection by port if type is missing
  if db_type == "" and db_port then
    if db_port == "3306" or db_port == "3307" then db_type = "mysql"
    elseif db_port == "5432" or db_port == "5433" then db_type = "postgres"
    elseif db_port == "1433" or db_port == "1434" then db_type = "sqlserver"
    end
  end

  local db_url = ""
  if db_type == "mysql" then
    db_url = string.format("mysql://%s:%s@%s:%s/%s", db_user, db_pass, db_host, db_port or "3306", db_name)
  elseif db_type == "postgres" then
    db_url = string.format("postgres://%s:%s@%s:%s/%s", db_user, db_pass, db_host, db_port or "5432", db_name)
  elseif db_type == "sqlserver" then
    db_url = string.format("sqlserver://sa:%s@%s:%s/%s", db_pass, db_host, db_port or "1433", db_name)
  end

  if db_url ~= "" then
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    vim.g.dbs = {
      { name = project_name, url = db_url }
    }
  end
end

setup_dadbod_connections()

-- 3. Keymaps
local set = vim.keymap.set
set("n", "<leader>du", "<cmd>DBUIToggle<cr>", { desc = "Toggle DBUI" })
set("n", "<leader>df", "<cmd>DBUIFindBuffer<cr>", { desc = "Find DB Buffer" })

-- 4. SQL Autocommand
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    set("n", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })
    set("v", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Selection" })
  end,
})

return {}
