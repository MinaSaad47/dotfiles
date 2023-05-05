return {
  cond = function()
    return not vim.g.vscode
  end,
  "ellisonleao/gruvbox.nvim",
  opts = {
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = false,
    contrast = "hard",
    dim_inactive = false,
    transparent_mode = true,
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.cmd [[colorscheme gruvbox]]
  end,
  lazy = false,
  priority = 1000,
}
