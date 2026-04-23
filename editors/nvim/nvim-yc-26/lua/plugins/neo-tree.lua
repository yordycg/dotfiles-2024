-- lua/plugins/neo-tree.lua
-- VS Code-like File Explorer
local status, neotree = pcall(require, "neo-tree")
if not status then return end

neotree.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      indent_size = 2,
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      default = "󰈚",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
    },
    git_status = {
      symbols = {
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "󰁕",
        untracked = "",
        ignored   = "",
        unstaged  = "󰄱",
        staged    = "",
        conflict  = "",
      },
    },
  },
  window = {
    position = "left",
    width = 30,
    mappings = {
      ["<space>"] = "none", -- Deshabilitar space para no interferir con Leader
      ["l"] = "open",
      ["h"] = "close_node",
      ["<cr>"] = "open",
      ["v"] = "open_vsplit",
      ["s"] = "open_split",
      ["a"] = "add", -- Añadir archivo/carpeta
      ["d"] = "delete", -- Borrar
      ["r"] = "rename", -- Renombrar
      ["c"] = "copy", -- Copiar
      ["m"] = "move", -- Mover
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
    },
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = {
        enabled = true,
    },
    use_libuv_file_watcher = true,
  },
})

-- Keymaps
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer (Neo-tree)" })
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree reveal<cr>", { desc = "Reveal File in Explorer" })
