-- lua/plugins/mini.lua
-- A collection of small, high-quality modules to replace dozens of plugins

-- Setup Icons
pcall(require, "mini.icons")
require("mini.icons").setup()

-- Setup Comments
require("mini.comment").setup()

-- Setup Surround
require("mini.surround").setup()

-- Setup Pairs
require("mini.pairs").setup()

-- Setup Indentscope
require("mini.indentscope").setup({
  symbol = "│",
  draw = { delay = 0, animation = require("mini.indentscope").gen_animation.none() },
})

-- Setup Statusline
require("mini.statusline").setup({ set_vim_settings = false })
