return {
  -- stylua: ignore
  keys = {
      { "<leader>D", mode = { "n", "x", "o" }, vim.lsp.buf.type_definition, desc = "Lsp type definition" },
      { "<leader>f", mode = { "n", "x", "o" }, function () vim.lsp.buf.format { async = false } end, desc = "Lsp type definition" },
      { "<leader>i", mode = { "n", "x", "o" }, function () vim.lsp.inlay_hint(0) end, desc = "Lsp inlay hints" },
      { "<leader>k", mode = { "n", "x", "o" }, vim.lsp.buf.signature_help, desc = "Lsp signature help" },
  },
  cond = function()
    return not vim.g.vscode
  end,
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {
      ui = {
        border = "rounded",
      },
    } },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", config = true },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None", bold = true, italic = true, blend = 100 })

        local lsp_signature = require "lsp_signature"

        local cfg = {
          doc_lines = 0,
          handler_opts = {
            border = "rounded",
          },
        }
        lsp_signature.setup(cfg)
      end,
    },
  },
  config = function()
    local lspconfig = require "lspconfig"
    local mason = require "mason"
    local cmp_nvim_lsp = require "cmp_nvim_lsp"

    -- Format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local on_attach = function(client, bufnr)
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { async = false, bufnr = bufnr }
          end,
        })

        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    mason.setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }

    -- Mason Lspconfig
    local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
    if mason_lspconfig_status then
      mason_lspconfig.setup {
        enensure_installed = { "lua_ls", "rust_analyzer", "clangd" },
      }
      mason_lspconfig.setup_handlers {
        ["pyright"] = function()
          lspconfig.pyright.setup {
            settings = {
              python = {
                inlayHints = {
                  functionReturnTypes = true,
                  variableTypes = true,
                },
              },
              capabilities = capabilities,
            },
            on_attach = on_attach,
          }
        end,
        ["tsserver"] = function()
          lspconfig.tsserver.setup {
            settings = {
              javascript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayVariableTypeHints = true,
                },
              },
              typescript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayVariableTypeHints = true,
                },
              },
              capabilities = capabilities,
            },
            on_attach = on_attach,
          }
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                  enable = false,
                },
              },
              capabilities = capabilities,
            },
            on_attach = on_attach,
          }
        end,
        function(server)
          lspconfig[server].setup(opts)
        end,
      }
    end
  end,
}
