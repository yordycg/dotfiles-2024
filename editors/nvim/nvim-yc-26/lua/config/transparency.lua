-- lua/config/transparency.lua
local M = {}

M.is_transparent = false

function M.toggle()
  M.is_transparent = not M.is_transparent
  
  local groups = {
    "Normal",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "LineNr",
    "CursorLineNr",
    "EndOfBuffer",
    "MsgArea",
    "Pmenu",
    "NormalNC", -- Non-current windows
  }

  if M.is_transparent then
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
    end
    print("Background: Transparent")
  else
    -- To restore, we simply reload the current colorscheme
    local colorscheme = vim.g.colors_name or "tokyonight"
    vim.cmd("colorscheme " .. colorscheme)
    print("Background: Opaque")
  end
end

-- Keymap
vim.keymap.set("n", "<leader>tt", M.toggle, { desc = "Toggle Transparency" })

return M
