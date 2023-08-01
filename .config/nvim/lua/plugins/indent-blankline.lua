return {
  cond = function()
    return not vim.g.vscode
  end,
  "lukas-reineke/indent-blankline.nvim",
  opts = {},
  config = function(_, ops)
    vim.opt.list = true
    vim.opt.listchars:append "eol:↴"
    require("indent_blankline").setup(ops)
  end,
}
