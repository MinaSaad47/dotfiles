local colorscheme = "gruvbox"


vim.g['gruvbox_contrast_dark'] = 'hard'
vim.opt.background = "dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

