local options = {
    ensure_installed = {
        "bash",
        "c", -- for c/cpp
        "cmake", -- for c/cpp
        "cpp", -- for c/cpp
        "fish",
        "lua",
        "luadoc",
        "make", -- for c/cpp
        "markdown",
        "printf",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
