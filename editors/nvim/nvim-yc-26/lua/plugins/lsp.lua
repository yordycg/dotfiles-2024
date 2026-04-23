-- lua/plugins/lsp.lua
-- Modern LSP Configuration for Neovim v0.11+
-- Uses the new native vim.lsp.config API

local status_mason, mason = pcall(require, "mason")
if not status_mason then return end

-- 1. Setup Mason for binary management
mason.setup({
  ui = { border = "rounded" }
})

-- 2. Define servers
local servers = {
  "ts_ls", "html", "cssls", "tailwindcss", "emmet_ls",
  "pyright", "ruff",
  "clangd", "omnisharp",
  "sqls", "lemminx", "bashls", "lua_ls", "dockerls", "jsonls", "yamlls",
  "kotlin_language_server",
}

-- 3. Global Diagnostics Config
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = { border = "rounded" },
})

-- 4. Get Capabilities (Blink.cmp integration)
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- 5. Global On Attach behavior
-- Using LspAttach autocmd (the modern way)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local set = vim.keymap.set
    
    -- Navigation
    set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
    set("n", "gr", require("fzf-lua").lsp_references, { desc = "Show references", buffer = bufnr })
    set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
    set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = bufnr })
    set("n", "gt", vim.lsp.buf.type_definition, { desc = "Type definition", buffer = bufnr })

    -- Actions
    set("n", "K", vim.lsp.buf.hover, { desc = "Hover info", buffer = bufnr })
    set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
    set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", buffer = bufnr })
    
    -- Diagnostics
    set("n", "<leader>D", vim.diagnostic.open_float, { desc = "Line diagnostics", buffer = bufnr })
    set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic", buffer = bufnr })
    set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", buffer = bufnr })
  end,
})

-- 6. Setup Each Server using the new native API
for _, server_name in ipairs(servers) do
  -- This replaces require('lspconfig')[server_name].setup()
  -- Neovim 0.11+ automatically finds configs in the 'lsp/' directory of nvim-lspconfig
  local config = vim.lsp.config[server_name]
  
  if config then
    -- Merge with our capabilities
    config = vim.deepcopy(config)
    config.capabilities = vim.tbl_deep_extend("force", config.capabilities or {}, capabilities)
    
    -- Emmet specific config
    if server_name == "emmet_ls" then
      config.filetypes = { "html", "htmldjango", "css", "scss", "javascriptreact", "typescriptreact" }
    end

    -- Lua specific config
    if server_name == "lua_ls" then
      config.settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
        },
      }
    end

    -- Start/Enable the server
    vim.lsp.enable(server_name, config)
  end
end
