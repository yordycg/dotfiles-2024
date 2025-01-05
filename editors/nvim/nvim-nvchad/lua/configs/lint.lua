local lint = require("lint")

lint.linter_by_ft = {
    lua = { "luacheck" },
}

lint.linters.luacheck.args = {
    -- unpack() it's deprecated
    -- table.unpack(lint.linters.luacheck.args),
    unpack(lint.linters.luacheck.args),
    "--globals",
    "love",
    "vim",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
