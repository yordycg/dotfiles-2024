local M = {}

local home = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
M.bg_blurred_darker = home .. "/workspace/infra/dotfiles-2024/os/cross-platform/wezterm/assets/bg-blurred-darker.png"
M.bg_blurred = home .. "/workspace/infra/dotfiles-2024/os/cross-platform/wezterm/assets/bg-blurred.png"
M.bg_image = M.bg_blurred_darker
-- M.bg_image = M.bg_blurred

return M