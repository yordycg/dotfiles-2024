return {
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact", "xml" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
  },
  {
    "ngtuonghy/live-server-nvim",
    event = "VeryLazy",
    build = ":LiveServerInstall",
    config = function()
      require("live-server-nvim").setup({})
    end,
    --
    cmd = { "LiveServerStart", "LiveServerStop", "LiveServerRestart" },
    ft = { "html", "css", "js", "ts", "svelte", "markdown" },
    -- keys = {
    --  { "<leader>ls", ":LiveServerStart<CR>", mode = "n", desc = "Start Live Server" },
    --  { "<leader>lc", ":LiveServerStop<CR>", mode = "n", desc = "Stop Live Server" },
    --  { "<leader>lr", ":LiveServerRestart<CR>", mode = "n", desc = "Restart Live Server" },
    -- },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      -- Import nvimm-autopairs
      local autopairs = require("nvim-autopairs")

      -- Configure autopairs
      autopairs.setup({
        check_ts = true, -- enable treesitter
        ts_config = {
          lua = { "string" }, -- don't add pairs in lua string treesitter nodes
          javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter nodes
          java = false, -- don't check treesitter on java
        },
      })

      -- Import nvim-autopairs completion functionality
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      -- Import nvim-cmp plugin (completions plugin)
      local cmp = require("cmp")

      -- Make autopairs and completion work together
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    config = function()
      require("colorizer").setup()
    end,
  },
}
