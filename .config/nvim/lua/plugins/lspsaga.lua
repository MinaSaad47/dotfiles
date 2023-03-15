return {
  cond = function()
    return not vim.g.vscode
  end,
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  config = function()
    local lspsaga = require "lspsaga"
    vim.diagnostic.config {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
    }
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    lspsaga.setup {
      ui = {
        border = "rounded",
        colors = {
          normal_bg = "#1D2021",
          title_bg = "#afd700",
          red = "#e95678",
          magenta = "#b33076",
          orange = "#FF8700",
          yellow = "#f7bb3b",
          green = "#afd700",
          cyan = "#36d0e0",
          blue = "#61afef",
          purple = "#CBA6F7",
          white = "#d1d4cf",
          black = "#1c1c19",
        },
      },
    }
    local keymap = vim.keymap.set
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
    keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
    keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
    keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
    keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
    keymap("n", "[E", function()
      require("lspsaga.diagnostic").goto_prev { severity = vim.diagnostic.severity.ERROR }
    end, { silent = true })
    keymap("n", "]E", function()
      require("lspsaga.diagnostic").goto_next { severity = vim.diagnostic.severity.ERROR }
    end, { silent = true })
    keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
    keymap("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
    keymap("n", "<A-g>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
    keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
  end,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter" },
  },
}
