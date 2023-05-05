return {
  cond = function()
    return not vim.g.vscode
  end,
  "nvim-lualine/lualine.nvim", -- language server
  config = true,
}
