local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify "[ERROR] requiring telescope"
end

telescope.setup {}
