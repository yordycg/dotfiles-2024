local wezterm = require("wezterm")

-- Add the dotfiles directory to the lua path
local dotfiles_dir = "C:/Users/yordycg/workspace/infra/dotfiles-2024/os/cross-platform/wezterm"
package.path = package.path .. ";" .. dotfiles_dir .. "/?.lua;" .. dotfiles_dir .. "/?/init.lua"

local commands = require("commands")
local constants = require("constants")

-- Load Resurrect Plugin
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local config = wezterm.config_builder()

-- Leader Key (Matches your tmux config: Ctrl+Space)
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  -- --- PANE MANAGEMENT (Splits) ---
  { key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "s", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },

  -- --- PANE NAVIGATION (Vim Style) ---
  -- With Leader (Matches your tmux)
  { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
  
  -- Direct (Alt + h/j/k/l) - Much faster for seniors
  { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },

  -- --- WINDOW/TAB MANAGEMENT ---
  { key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "H", mods = "LEADER|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "L", mods = "LEADER|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
  {
    key = "r",
    mods = "LEADER",
    action = wezterm.action.PromptInputLine({
      description = "Rename Tab:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then window:active_tab():set_title(line) end
      end),
    }),
  },

  -- --- WORKSPACE/SESSION MANAGEMENT ---
  -- List workspaces (SessionX style)
  { key = "w", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  -- New Workspace with name
  {
    key = "n", -- 'n' de New Session
    mods = "LEADER",
    action = wezterm.action.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace:" },
      }),
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(wezterm.action.SwitchToWorkspace({ name = line }), pane)
        end
      end),
    }),
  },
  -- Rename current Workspace
  {
    key = "$",
    mods = "LEADER|SHIFT",
    action = wezterm.action.PromptInputLine({
      description = "Rename Workspace:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line) end
      end),
    }),
  },

  -- --- RESURRECT (Sessions) ---
  {
    key = "U", -- 'U' de Update (Save)
    mods = "LEADER|SHIFT",
    action = wezterm.action_callback(function(win, pane)
      resurrect.save_state(resurrect.workspace_state.get_workspace_state())
      win:toast_notification("WezTerm", "Session Saved!", nil, 4000)
    end),
  },
  {
    key = "R", -- 'R' de Restore (Load)
    mods = "LEADER|SHIFT",
    action = wezterm.action_callback(function(win, pane)
      resurrect.load_state(resurrect.workspace_state.get_workspace_state())
      win:toast_notification("WezTerm", "Session Restored!", nil, 4000)
    end),
  },

  -- --- PANE RESIZING (Alt + Arrows) ---
  { key = "LeftArrow",  mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
  { key = "DownArrow",  mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
  { key = "UpArrow",    mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
  { key = "RightArrow", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },

  -- --- POPUPS & QUICK APPS ---
  { key = "g", mods = "ALT", action = wezterm.action.SpawnCommandInNewWindow({ args = { "lazygit" } }) },
}

-- Shell configuration
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- Font settings
config.font = wezterm.font_with_fallback({
  { family = "JetBrains Mono", weight = "Medium" },
  { family = "RobotoMono Nerd Font Mono" },
  { family = "Symbols Nerd Font Mono" },
})
config.font_size = 11.0
config.line_height = 1.0
config.cell_width = 1.0

-- Fix visual scaling/jump
config.adjust_window_size_when_changing_font_size = false

-- Appearance
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.window_background_image = constants.bg_image
config.macos_window_background_blur = 40
config.win32_system_backdrop = 'Acrylic'
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }

-- Performance
config.max_fps = 120
config.prefer_egl = true

-- Custom commands
wezterm.on("augment-command-palette", function() return commands end)

return config
