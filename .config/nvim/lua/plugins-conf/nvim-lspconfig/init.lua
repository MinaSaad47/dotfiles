local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    print("[ERROR] requiring nvim-lspconfig")
    return
end

local status_ok, mason = pcall(require, "mason")
if not status_ok then
    print("[ERROR] requiring mason")
    return
end

-- For `Enable Diagnostic in hover window`
vim.o.updatetime = 250

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)

    -- Enable Diagnostic in hover window
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lua = require('cmp_nvim_lsp')
if status_ok then
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

local opts = {
    on_attach = on_attach,
    capabilities = capabilities
}

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if status_ok then
    mason_lspconfig.setup()
    mason_lspconfig.setup_handlers {
        function(server)
            lspconfig[server].setup(opts)
        end
    }
end




vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Enable Inlay Hints
local status_ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
if status_ok then
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
            vim.keymap.set('n', '<C-i>', lsp_inlayhints.toggle, bufopts)
        end,
    })
end


-- Lsp Progress Indicator
local status_ok, fidget = pcall(require, "fidget")
if status_ok then
    fidget.setup()
end
