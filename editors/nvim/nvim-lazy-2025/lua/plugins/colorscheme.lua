return {
  -- Catppuccin --------------------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- queremos que tenga prioridad al cargar el plugin
    priority = 1000,
    opts = {
      -- Your configuration options here
      flavour = "macchiato", -- latte | frappe | macchiato | mocha
      -- transparent_background = true, -- true | false
    },
  },
  -- Onedark --------------------------------------------------------------------
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      -- Your configuration options here
      style = "deep", -- dark | darker | cool | deep | warm | warmer | light
      -- transparent = true, -- true | false
      -- Change code style
      -- italic | bold | underline | none
      code_style = {
        comments = "none",
      },
    },
  },
  -- Flow --------------------------------------------------------------------
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Your configuration options here
      theme = {
        style = "dark", -- dark | light
        -- transparent = true, -- true | false
      },
    },
  },
  -- VSCode --------------------------------------------------------------------
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Your configuration options here
      style = "dark", -- dark | light
      -- transparent = true, -- true | false
      italic_comments = false, -- true | false
    },
  },
  -- Material --------------------------------------------------------------------
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Your configuration options here
      disable = {
        -- background = true, -- enable transparency
      },
    },
    init = function()
      vim.g.material_style = "palenight" -- darker | lighter | oceanic | palenight | deep ocean
    end,
  },
  -- TODO: no me funciona esta configuracion!, no puedo settear el estilo 'oh-lucy-evening'
  -- Oh lucy --------------------------------------------------------------------
  -- {
  -- "Yazeed1s/oh-lucy.nvim",
  -- lazy = false,
  -- priority = 1000,
  -- main = 'oh-lucy',
  -- config = function()
  -- set_colorscheme("oh-lucy-evening"); -- oh-lucy | oh-lucy-evening
  -- end
  -- },
  -- TODO: no funciona, error con Snacks en ui.lua:111
  {
    "aliqyan-21/darkvoid.nvim",
    priority = 1000,
    config = function()
      require("darkvoid").setup({
        transparent = false,
        glow = false,
        colors = {
          line_nr = "#505050",
          -- comment = "#a6a2a2",
          comment = "#989898",
          plugins = {
            nvim_cmp = false,
            -- lualine = false, -- solution to Snacks | ui.lua:111
          },
        },
      })
    end,
  },
  -- TODO: crear una funcion o keymap para tener la transparencia on/off
  -- TRANSPARENT ---------------------------------------------------------------------------------------
  {
    "xiyaowong/transparent.nvim",
  },
  -- COLORSCHEME ---------------------------------------------------------------------------------------
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "darkvoid",
      colorscheme = "onedark",
    },
  },

  vim.keymap.set("n", "<leader>bg", "<cmd> :Transparent_toggle <CR>", { noremap = true, silent = true }),
}
