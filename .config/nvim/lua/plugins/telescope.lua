return {
  cond = function()
    return not vim.g.vscode
  end,
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function(_, opts)
    require("telescope").setup(opts)

    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "FloatBorder" })
  end,
  cmd = "Telescope",
  keys = {
    { "<leader>tf", mode = { "n", "x", "o" }, "<CMD>Telescope find_files <CR>", desc = "Telescope find files" },
    { "<leader>tg", mode = { "n", "x", "o" }, "<CMD>Telescope grep_string <CR>", desc = "Telescope grep string" },
    { "<leader>tb", mode = { "n", "x", "o" }, "<CMD>Telescope buffers <CR>", desc = "Telescope buffers" },
    { "<leader>tr", mode = { "n", "x", "o" }, "<CMD>Telescope registers <CR>", desc = "Telescope registers" },
  },
}
