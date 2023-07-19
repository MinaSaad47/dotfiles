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
