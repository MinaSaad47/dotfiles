local colorscheme = "gruvbox"
vim.o.background = "dark"
local status, gruvbox = pcall(require, colorscheme)
if status then
  gruvbox.setup {
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = false, -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
  }
  vim.cmd("colorscheme" .. " " .. colorscheme)
else
  vim.notify("colorscheme " .. colorscheme .. " not found!")
end
