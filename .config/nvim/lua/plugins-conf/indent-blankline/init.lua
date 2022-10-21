vim.opt.list = true
vim.opt.listchars:append "eol:↴"

local status_ok, ib = pcall(require, "indent_blankline")
if not status_ok then
  vim.notify "[ERROR] requiring indent_blankline"
  return
end

ib.setup {
  show_end_of_line = true,
}
