return {
  cond = function()
    return not vim.g.vscode
  end,
  "nvim-lualine/lualine.nvim", -- language server
  opts = {
    options = {
      component_separators = "",
      section_separators = "",
    },
  },
}
