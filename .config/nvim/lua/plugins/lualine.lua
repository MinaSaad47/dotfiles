return {
  cond = function()
    return not vim.g.vscode
  end,
  "nvim-lualine/lualine.nvim", -- language server
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
  opts = {
    options = {
      theme = "gruvbox",
    },
  },
}
