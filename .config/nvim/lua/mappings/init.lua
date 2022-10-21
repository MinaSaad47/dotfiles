local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<C-n>", ":NvimTreeToggle <CR>", opts)
map("n", "<C-f>", ":Telescope find_files <CR>", opts)
