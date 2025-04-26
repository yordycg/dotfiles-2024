return {
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
}
