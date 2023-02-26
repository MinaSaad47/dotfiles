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
    function(server)
      lspconfig[server].setup(opts)
    end,
  }
end

-- Manual Setup
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  on_attach = on_attach,
}

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

local keymap = vim.keymap.set
local lspsaga_status, lspsaga = pcall(require, "lspsaga")
if lspsaga_status then
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
end

-- neodev
local status_ok, neodev = pcall(require, "neodev")
if status_ok then
  neodev.setup()
end
