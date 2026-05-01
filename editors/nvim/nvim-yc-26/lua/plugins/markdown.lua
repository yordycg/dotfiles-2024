-- lua/plugins/markdown.lua
-- Enhanced Markdown rendering in the buffer

local status, render_markdown = pcall(require, "render-markdown")
if not status then return end

render_markdown.setup({
  heading = {
    -- Turn on / off heading icon & background rendering
    enabled = true,
    -- Turn on / off any sign column related rendering
    sign = true,
    -- Determines how icons fill the heading line
    position = 'overlay',
    -- Replaces '# ' with icons
    icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    -- Added to the end of query results
    signs = { '󰫎 ' },
  },
  code = {
    -- Turn on / off code block & inline code rendering
    enabled = true,
    -- Turn on / off any sign column related rendering
    sign = true,
    -- Determines how code blocks & inline code are rendered:
    --  none:   no rendering
    --  normal: render code blocks & inline code
    --  language: render code blocks with language icon
    style = 'full',
    position = 'left',
    -- Amount of padding to add to the left of code blocks
    left_pad = 2,
    -- Amount of padding to add to the right of code blocks
    right_pad = 2,
    -- Width of the code block background
    width = 'block',
    -- Icon to use for code blocks
    border = 'thin',
  },
  bullet = {
    -- Turn on / off bullet rendering
    enabled = true,
    -- Replaces '-'|'+'|'*' with icons
    icons = { '●', '○', '◆', '◇' },
    -- Padding to add to the left of bullet point
    left_pad = 0,
    -- Padding to add to the right of bullet point
    right_pad = 0,
  },
  checkbox = {
    -- Turn on / off checkbox rendering
    enabled = true,
    unchecked = { icon = '󰄱 ' },
    checked = { icon = '󰄲 ' },
    todo = { icon = '󰄱 ' },
  },
})
