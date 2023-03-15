return {
  cond = function()
    return not vim.g.vscode
  end,
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  cmd = "Telescope",
}
