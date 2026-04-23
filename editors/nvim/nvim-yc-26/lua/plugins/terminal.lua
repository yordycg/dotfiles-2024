-- lua/plugins/terminal.lua
-- Floating Terminal for nvim-yc-26
local set = vim.keymap.set

-- Variable para guardar el estado del buffer/ventana de la terminal
local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calcular posición central
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Crear buffer si no existe
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Definir opciones de la ventana
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.fn.termopen(os.getenv("SHELL") or "bash")
    end
    -- Auto-insert mode when opening
    vim.cmd("startinsert")
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Atajo principal: Leader + t para abrir/cerrar
set({"n", "t"}, "<leader>t", toggle_terminal, { desc = "Toggle Terminal" })

-- Esc Esc para cerrar la terminal desde adentro
set("t", "<esc><esc>", function()
  toggle_terminal()
end, { desc = "Close Terminal" })

return {}
