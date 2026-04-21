-- lua/plugins/theme.lua
-- Sophisticated Theme Switcher using FZF-Lua
local status, fzf = pcall(require, "fzf-lua")
if not status then return end

local M = {}

-- Directory where themes are stored
local themes_dir = vim.fn.stdpath("config") .. "/lua/themes"

-- Function to load a specific theme
function M.load_theme(theme_name)
  -- Clear lua cache for this theme so it can be re-loaded
  package.loaded["themes." .. theme_name] = nil
  local ok, err = pcall(require, "themes." .. theme_name)
  if not ok then
    vim.notify("Error loading theme " .. theme_name .. ": " .. err, vim.log.levels.ERROR)
  else
    -- Save the selection to a persistent file (optional, for next session)
    local state_path = vim.fn.stdpath("data") .. "/yc_theme_state.lua"
    local f = io.open(state_path, "w")
    if f then
      f:write('return "' .. theme_name .. '"')
      f:close()
    end
  end
end

-- Function to open the theme picker
function M.select_theme()
  local themes = {}
  -- Scan the themes directory
  local files = vim.split(vim.fn.globpath(themes_dir, "*.lua"), "\n")
  for _, file in ipairs(files) do
    if file ~= "" then
      local name = vim.fn.fnamemodify(file, ":t:r")
      table.insert(themes, name)
    end
  end

  fzf.fzf_exec(themes, {
    actions = {
      ["default"] = function(selected)
        M.load_theme(selected[1])
      end,
    },
    winopts = {
      height = 0.4,
      width = 0.3,
      title = " 🎨 Select Theme ",
    },
  })
end

-- Command to open the picker
vim.api.nvim_create_user_command("ThemeSelect", M.select_theme, {})
vim.keymap.set("n", "<leader>th", M.select_theme, { desc = "Select Theme (FZF)" })

-- Load the last used theme on startup
local state_path = vim.fn.stdpath("data") .. "/yc_theme_state.lua"
local ok, last_theme = pcall(dofile, state_path)
if ok and type(last_theme) == "string" then
  M.load_theme(last_theme)
else
  -- Default theme if no state exists
  M.load_theme("tokyonight")
end

return M
