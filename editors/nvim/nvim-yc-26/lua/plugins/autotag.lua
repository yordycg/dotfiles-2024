-- lua/plugins/autotag.lua
-- Auto-close and auto-rename HTML-like tags
local status, autotag = pcall(require, "nvim-ts-autotag")
if not status then return end

autotag.setup({
  opts = {
    -- Defaults
    enable_close = true,           -- Auto close tags
    enable_rename = true,          -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
  -- Also activate for Django/Jinja templates
  filetypes = {
    "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "rescript",
    "xml", "php", "markdown", "astro", "glimmer", "handlebars", "haml", "htmldjango"
  },
})
