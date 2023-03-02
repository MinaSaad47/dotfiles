local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  print "[ERROR] requiring nvim-lspconfig"
  return
end

-- Format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  -- Format on save
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lua_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lua_status then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local opts = {
  capabilities = capabilities,
  on_attach = on_attach,
}
-- Mason
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  print "[ERROR] requiring mason"
  return
end

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
    ["clangd"] = function()
      lspconfig.clangd.setup {
        cmd = {
          "clangd",
          "--fallback-style",
          "~/.config/.clang-format",
        },
        capabilities = capabilities,
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
      }
    end,
    function(server)
      lspconfig[server].setup(opts)
    end,
  }
end

-- Enable Inlay Hints
local lsp_inlayhints_status, lsp_inlayhints = pcall(require, "lsp-inlayhints")
if lsp_inlayhints_status then
  lsp_inlayhints.setup()
  vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
  vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspAttach_inlayhints",
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      lsp_inlayhints.on_attach(client, bufnr)

      -- keybinding
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "<C-i>", lsp_inlayhints.toggle, bufopts)
    end,
  })
end

-- Lsp Progress Indicator
local fidgets_status, fidget = pcall(require, "fidget")
if fidgets_status then
  fidget.setup()
end

-- neodev
local status_ok, neodev = pcall(require, "neodev")
if status_ok then
  neodev.setup()
end
