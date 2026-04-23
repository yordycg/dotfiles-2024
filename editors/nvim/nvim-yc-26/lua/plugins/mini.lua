-- lua/plugins/mini.lua
-- A collection of small, high-quality modules to replace dozens of plugins

-- Safe Setup Helper
local function setup_mini(module_name, opts)
  local status, mini_module = pcall(require, "mini." .. module_name)
  if status then
    mini_module.setup(opts or {})
  else
    print("Mini: Could not load " .. module_name)
  end
end

-- 1. Setup Comments (gc, gcc)
setup_mini("comment")

-- 2. Setup Surround (sa, sd, sr)
setup_mini("surround")

-- 3. Setup Pairs (Auto-close brackets)
setup_mini("pairs")

-- 4. Setup Indentscope (Vertical guide)
setup_mini("indentscope", {
  symbol = "│",
  draw = { delay = 0, animation = function() return 0 end },
})

-- 5. Setup Statusline
setup_mini("statusline", { set_vim_settings = false })

-- 6. Setup Icons (Disabled: Using nvim-web-devicons for Neo-tree)
-- pcall(require, "mini.icons")
-- require("mini.icons").setup()
