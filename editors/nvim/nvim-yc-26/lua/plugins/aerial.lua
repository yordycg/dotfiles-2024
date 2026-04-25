-- lua/plugins/aerial.lua
-- Code structure outline (symbols)

local status, aerial = pcall(require, "aerial")
if not status then return end

aerial.setup({
  -- Priority of sources for symbols
  backends = { "lsp", "treesitter", "markdown", "man" },

  layout = {
    -- These control the width of the aerial window.
    max_width = { 40, 0.2 },
    width = nil,
    min_width = 30,
    default_direction = "right",
    placement = "window",
  },

  -- Determines how the aerial window decides which buffer to display symbols for
  attach_mode = "window",

  -- List of symbol kinds to display
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },

  -- Keymaps for the aerial window
  keymaps = {
    ["?"] = "actions.show_help",
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["p"] = "actions.scroll",
    ["<C-j>"] = "actions.down_and_scroll",
    ["<C-k>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["[["] = "actions.prev_up",
    ["]]"] = "actions.next_up",
    ["q"] = "actions.close",
  },

  -- Show icons for symbols
  icons = {
    Class = "󰠱 ",
    Constructor = " ",
    Enum = " ",
    Function = "󰊕 ",
    Interface = " ",
    Method = "󰊕 ",
    Module = "󰏗 ",
    Struct = "󰙅 ",
  },
})

-- Keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Symbols Outline" })

return {}
