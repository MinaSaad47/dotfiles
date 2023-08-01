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
      scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
      },
      ui = {
        border = "rounded",
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
    keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
    keymap("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>", { silent = true })
    keymap("n", "<A-g>", "<cmd>Lspsaga term_toggle lazygit<CR>", { silent = true })
    keymap("n", "[E", function()
      require("lspsaga.diagnostic").goto_prev { severity = vim.diagnostic.severity.ERROR }
    end, { silent = true })
    keymap("n", "]E", function()
      require("lspsaga.diagnostic").goto_next { severity = vim.diagnostic.severity.ERROR }
    end, { silent = true })
  end,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter" },
  },
}
