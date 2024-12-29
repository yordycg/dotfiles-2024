local api = vim.api

-- Don't auto comment new line
api.nvim_create_autocmd('BufEnter', { command = [[set formatoptions-=cro]] })
