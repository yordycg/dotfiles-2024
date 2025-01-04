-- Configurar el tipo de archivo para C++
vim.cmd [[
  autocmd BufNewFile,BufRead *.cpp set filetype=cpp
]]

function CompileAndRun()
  local fileName = vim.fn.expand '%'
  if string.match(fileName, '%.cpp$') then
    local exeName = string.gsub(fileName, '%.cpp$', '')

    -- Compilar el archivo C++
    local compile_cmd = string.format('g++ -std=c++11 -Wall -Wextra -Wpedantic -ggdb -O2 -DNDEBUG -o %s %s', exeName, fileName)
    vim.cmd 'write' -- Guardar el archivo
    local compile_result = vim.fn.system(compile_cmd)

    -- Verificar si la compilación fue exitosa
    if vim.v.shell_error == 0 then
      -- Cambiar al directorio del archivo fuente para ejecutar el binario
      local dir = vim.fn.expand '%:p:h' -- Obtener el directorio del archivo
      local run_cmd = string.format('wezterm start --always-new-process -- bash -c \'cd %s && ./%s; read -p "Press enter to exit..."\'', dir, exeName)
      vim.fn.system(run_cmd)
      vim.cmd 'redraw!'
    else
      print 'Compilation failed!'
    end
  else
    print 'Not a C++ file'
  end
end

-- Mapear teclas para compilar y ejecutar
vim.api.nvim_set_keymap('n', '<F5>', ':lua CompileAndRun()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F9>', ':write<CR>:!clear<CR>:lua CompileAndRun()<CR>', { noremap = true, silent = true })
