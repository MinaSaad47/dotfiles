return {
  cond = function()
    return not vim.g.vscode
  end,
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      numbers = "bufer id",
      saperator_style = "slope",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
    },
  },
}
