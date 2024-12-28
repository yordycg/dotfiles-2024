local wezterm = require("wezterm")
local commands = require("commands")
local constants = require("constants")

local config = wezterm.config_builder()

-- Font settings
config.font_size = 13
config.line_height = 1.2
config.font = wezterm.font("CaskaydiaCove Nerd Font")
-- config.font = wezterm.font("DankMono Nerd Font")

-- Colors
config.colors = {
  cursor_bg = "white",
  cursor_border = "white",
  indexed = { [239] = "lightslategrey" },
}

-- Appearance
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_image = constants.bg_image
config.macos_window_background_blur = 40 -- effect in macOS
config.win32_system_backdrop = 'Acrylic' -- effect in windows
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

-- Miscellaneous settings
config.max_fps = 120
config.prefer_egl = true

-- Custom commands
wezterm.on("augment-command-palette", function()
  return commands
end)

return config