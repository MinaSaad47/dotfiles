return {
  cond = function()
    return not vim.g.vscode
  end,
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = true,
  cmd = "NvimTreeToggle",
}
