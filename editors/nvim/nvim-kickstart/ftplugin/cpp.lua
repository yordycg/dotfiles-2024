-- Config ftplugin for C++
local opt_local = vim.opt_local
local opt = vim.opt
local cmd = vim.cmd
local map = vim.keymap.set

-- Function for compile and run in terminal neovim
local function compile_and_run()
  local file_name = vim.fn.expand '%'

  -- verificar si es un archivo cpp
  if string.match(file_name, '%.cpp$') then
    -- obtener nombre del ejecutable
    local exe_name = string.gsub(file_name, '%.cpp$', '')

    -- guardar arhivo
    cmd 'write'

    -- comando de compilacion
    -- -std=c++20 for projects
    -- -std=c++23 for personal use
    local compile_cmd = string.format(
      'g++ -std=c++23 -Wall -Weffc++ -Wextra -Wconversion -Wsing-conversion -Wpedantic -Werror -ggdb -O2 -DNDEBUG -pedantic-errors -o %s %s',
      exe_name,
      file_name
    )

    -- -- verificar si la compilación fue exitosa
    -- if vim.v.shell_error == 0 then
    --   -- cambiar al directorio del archivo fuente para ejecutar el binario
    --   local dir = vim.fn.expand '%:p:h' -- obtener el directorio del archivo
    --
    --   -- abrir terminal horizontal abajo
    --   cmd 'belowright split'
    --   cmd 'resize 20' -- altura de 20 lineas
    --
    --   local run_cmd = string.format(
    --     -- 'wezterm start --always-new-process -- bash -c \'cd %s && ./%s; read -p "Press enter to exit..."\'',
    --     'term bash -c \'%s && echo "Compilation successful! Running program..." && ./%s; read -p "Press enter to exit..." ',
    --     dir,
    --     exe_name
    --   )
    --   cmd(run_cmd)
    --
    --   -- entrar al modo normal en la terminal
    --   -- cmd 'normal! G'
    --   -- cmd 'starinsert'
    --   vim.cmd 'normal! G'
    --   vim.cmd 'startinsert'
    -- else
    --   print 'Compilation failed!'
    -- end
    -- abrir terminal horizontal abajo
    cmd 'belowright split'
    cmd 'resize 20' -- altura de 20 lineas

    local run_cmd = string.format(
      -- 'wezterm start --always-new-process -- bash -c \'cd %s && ./%s; read -p "Press enter to exit..."\'',
      'term bash -c "%s && echo Compilation successful! Running program... && ./%s; read -p \\"Press enter to exit...\\"; exit " ',
      compile_cmd,
      exe_name
    )
    cmd(run_cmd)

    -- entrar al modo normal en la terminal
    vim.cmd 'normal! G'
    vim.cmd 'startinsert'

    -- autocmd para cerrar la terminal cuando termine
    vim.api.nvim_create_autocmd('TermClose', {
      pattern = '*',
      callback = function()
        cmd 'quit'
      end,
      once = true,
    })
  else
    print 'Not a C++ file'
  end
end

-- Function to open/close terminal
local function close_terminal()
  -- buscar el buffer de la terminal
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == 'terminal' then
      -- cerrar la ventana que contiene la terminal
      local wins = vim.fn.win_findbuf(buf)
      for _, win in ipairs(wins) do
        vim.api.nvim_win_close(win, true)
      end
    end
  end
end

-- MAPPING THE FUNCTIONS
map('n', '<F5>', function()
  close_terminal()
  compile_and_run()
end, { buffer = true, silent = true })

-- ESC for out mode terminal
map('t', '<ESC>', [[<C-\><C-n>:q<CR>]], { buffer = true, noremap = true })
map('t', '<C-[>', [[<C-\><C-n>:q<CR>]], { buffer = true, noremap = true })

-- Format code with clang-format
map('n', '<Leader>f', function()
  cmd 'write' -- guardar archivo
  cmd '!clang-format -i %' -- formatear archivo
  cmd 'e' -- recargar archivo
end, { buffer = true, silent = true })

-- Indentation
opt_local.shiftwidth = 4
opt_local.tabstop = 4
opt_local.expandtab = true
opt_local.autoindent = true
opt_local.smartindent = true

-- Configure CLI
opt.cmdheight = 1

-- Numbers in line
opt_local.number = true
opt_local.relativenumber = true

-- Especific config for C++
opt_local.cindent = true -- indentacion especifica para C
opt_local.cinoptions = 'g0,(0,W4' -- ajustar la indentacion de llaves y parenteis
opt_local.colorcolumn = '80' -- linea guia en la columna 80
opt_local.textwidth = 80 -- ancho maximo del codigo
opt_local.wrap = false -- no envolver lineas largas
