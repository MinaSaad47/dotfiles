return {
  cond = function()
    return not vim.g.vscode
  end,
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    local null_ls = require "null-ls"
    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format {
        filter = function(client)
          return client.name == "null-ls"
        end,
        bufnr = bufnr,
      }
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end
    end

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
      debug = true,
      sources = {
        formatting.stylua,
        formatting.jq,
        formatting.prettierd,
        diagnostics.eslint_d,
      },
      on_attach = on_attach,
    }
  end,
}
