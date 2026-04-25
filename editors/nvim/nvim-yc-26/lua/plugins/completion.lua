-- lua/plugins/completion.lua
-- Blink.cmp: The next-generation completion engine written in Rust
local status, blink = pcall(require, "blink.cmp")
if not status then return end

blink.setup({
  -- Custom keymaps (Blink style)
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "hide" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },

  appearance = {
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    nerd_font_variant = "mono"
  },

  -- Sources for autocomplete
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "dadbod" },
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
    },
  },

  completion = {
    -- Show menu automatically, but no documentation unless requested
    menu = { auto_show = true },
    ghost_text = { enabled = true },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },

  -- Experimental features
  fuzzy = {
    implementation = "prefer_rust", -- Maximum speed
  },
})
