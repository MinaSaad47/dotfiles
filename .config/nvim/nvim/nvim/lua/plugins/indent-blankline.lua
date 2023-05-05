return {
  cond = function()
    return not vim.g.vscode
  end,
  "lukas-reineke/indent-blankline.nvim",
  opts = {
    show_end_of_line = true,
  },
}
