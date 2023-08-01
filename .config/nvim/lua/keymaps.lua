local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ "n" }, "<leader>h", "<cmd>bp<cr>", opts)
map({ "n" }, "<leader>l", "<cmd>bn<cr>", opts)

map({ "n" }, "<C-h>", "<C-w>h", opts)
map({ "n" }, "<C-l>", "<C-w>l", opts)
map({ "n" }, "<C-j>", "<C-w>j", opts)
map({ "n" }, "<C-k>", "<C-w>k", opts)

map({ "n" }, "<C-=>", "<cmd>vert resize +1<cr>", opts)
map({ "n" }, "<C-->", "<cmd>vert resize -1<cr>", opts)
map({ "n" }, "<A-=>", "<cmd>resize +1<cr>", opts)
map({ "n" }, "<A-->", "<cmd>resize -1<cr>", opts)

local compile_based_on_filetype = function()
  local ft = vim.bo.filetype
  vim.cmd [[write]]
  if ft == "cpp" then
    vim.cmd [[te g++ % -o /tmp/%:r && /tmp/%:r]]
  elseif ft == "c" then
    vim.cmd [[te gcc % -o /tmp/%:r && /tmp/%:r]]
  elseif ft == "python" then
    vim.cmd [[python3 %]]
  elseif ft == "rust" then
    vim.cmd [[cargo r -q]]
  elseif ft == "javascript" then
    vim.cmd [[node %]]
  end
end

map({ "n" }, "<F5>", compile_based_on_filetype, opts)
