-- lua/plugins/glance.lua
-- Peek definition and references like VS Code

local status, glance = pcall(require, "glance")
if not status then return end

glance.setup({
  height = 20, -- Height of the window
  zindex = 45,
  detached = true, -- Close automatically when cursor moves
  border = {
    enable = true,
    top_char = "―",
    bottom_char = "―",
    left_char = "│",
    right_char = "│",
    top_left_char = "╭",
    top_right_char = "╮",
    bottom_left_char = "╰",
    bottom_right_char = "╯",
  },
  list = {
    position = "right",
    width = 0.33, -- 33% width for the side list
  },
  theme = {
    enable = true, -- Automatically derive colors from the current colorscheme
    mode = "auto",
  },
  mappings = {
    list = {
      ["j"] = glance.actions.next,
      ["k"] = glance.actions.previous,
      ["<Down>"] = glance.actions.next,
      ["<Up>"] = glance.actions.previous,
      ["<Tab>"] = glance.actions.next_location,
      ["<S-Tab>"] = glance.actions.previous_location,
      ["<leader>l"] = glance.actions.enter_win("preview"), -- Focus preview
      ["v"] = glance.actions.jump_vsplit,
      ["s"] = glance.actions.jump_split,
      ["t"] = glance.actions.jump_tab,
      ["<CR>"] = glance.actions.jump,
      ["o"] = glance.actions.jump,
      ["q"] = glance.actions.close,
      ["Q"] = glance.actions.close,
      ["<Esc>"] = glance.actions.close,
    },
    preview = {
      ["q"] = glance.actions.close,
      ["<Tab>"] = glance.actions.next_location,
      ["<S-Tab>"] = glance.actions.previous_location,
      ["<leader>l"] = glance.actions.enter_win("list"), -- Focus list
    },
  },
})

-- Keymaps
local set = vim.keymap.set

set("n", "gpd", "<cmd>Glance definitions<CR>", { desc = "Glance Definition (Peek)" })
set("n", "gpr", "<cmd>Glance references<CR>", { desc = "Glance References (Peek)" })
set("n", "gpi", "<cmd>Glance implementations<CR>", { desc = "Glance Implementation (Peek)" })
set("n", "gpt", "<cmd>Glance type_definitions<CR>", { desc = "Glance Type Definition (Peek)" })

return {}
