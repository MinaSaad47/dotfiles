local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>ff", "<CMD>Telescope find_files <CR>", opts)
map("n", "<leader>fg", "<CMD>Telescope grep_string <CR>", opts)
map("n", "<leader>fb", "<CMD>Telescope buffers <CR>", opts)
map("n", "<leader>fr", "<CMD>Telescope registers <CR>", opts)

return {
  cond = function()
    return not vim.g.vscode
  end,
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  cmd = "Telescope",
}
