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
    --
    -- /* Some commented for lspsaga */
    --
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)

    -- Enable Diagnostic in hover window
    --
    -- /* Disabled for lspsaga */
    --
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --     buffer = bufnr,
    --     callback = function()
    --         local opts = {
    --             focusable = false,
    --             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --             border = 'rounded',
    --             source = 'always',
    --             prefix = ' ',
    --             scope = 'cursor',
    --         }
    --         vim.diagnostic.open_float(nil, opts)
    --     end
    -- })
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


local keymap = vim.keymap.set
local status_ok, saga = pcall(require, 'lspsaga')
if status_ok then
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

    saga.init_lsp_saga({
        -- Options with default value
        -- "single" | "double" | "rounded" | "bold" | "plus"
        border_style = "rounded",
        --the range of 0 for fully opaque window (disabled) to 100 for fully
        --transparent background. Values between 0-30 are typically most useful.
        saga_winblend = 0,
        -- when cursor in saga window you config these to move
        move_in_saga = { prev = '<C-p>',next = '<C-n>'},
        -- Error, Warn, Info, Hint
        -- use emoji like
        -- { "🙀", "😿", "😾", "😺" }
        -- or
        -- { "😡", "😥", "😤", "😐" }
        -- and diagnostic_header can be a function type
        -- must return a string and when diagnostic_header
        -- is function type it will have a param `entry`
        -- entry is a table type has these filed
        -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
        diagnostic_header = { " ", " ", " ", "ﴞ " },
        -- preview lines of lsp_finder and definition preview
        max_preview_lines = 10,
        -- use emoji lightbulb in default
        code_action_icon = "💡",
        -- if true can press number to execute the codeaction in codeaction window
        code_action_num_shortcut = true,
        -- same as nvim-lightbulb but async
        code_action_lightbulb = {
            enable = true,
            enable_in_insert = true,
            cache_code_action = true,
            sign = true,
            update_time = 150,
            sign_priority = 20,
            virtual_text = true,
        },
        -- finder icons
        finder_icons = {
          def = '  ',
          ref = '諭 ',
          link = '  ',
        },
        -- finder do lsp request timeout
        -- if your project big enough or your server very slow
        -- you may need to increase this value
        finder_request_timeout = 1500,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            tabe = "t",
            quit = "q",
        },
        code_action_keys = {
            quit = "q",
            exec = "<CR>",
        },
        definition_action_keys = {
          edit = '<C-c>o',
          vsplit = '<C-c>v',
          split = '<C-c>i',
          tabe = '<C-c>t',
          quit = 'q',
        },
        rename_action_quit = "<C-c>",
        rename_in_select = true,
        -- show symbols in winbar must nightly
        -- in_custom mean use lspsaga api to get symbols
        -- and set it to your custom winbar or some winbar plugins.
        -- if in_cusomt = true you must set in_enable to false
        symbol_in_winbar = {
            in_custom = true,
            enable = true,
            separator = ' ',
            show_file = true,
            -- define how to customize filename, eg: %:., %
            -- if not set, use default value `%:t`
            -- more information see `vim.fn.expand` or `expand`
            -- ## only valid after set `show_file = true`
            file_formatter = "",
            click_support = false,
        },
        -- show outline
        show_outline = {
          win_position = 'right',
          --set special filetype win that outline window split.like NvimTree neotree
          -- defx, db_ui
          win_with = '',
          win_width = 30,
          auto_enter = true,
          auto_preview = true,
          virt_text = '┃',
          jump_key = 'o',
          -- auto refresh when change buffer
          auto_refresh = true,
        },
        -- custom lsp kind
        -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
        custom_kind = {},
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- like server_filetype_map = { metals = { "sbt", "scala" } }
        server_filetype_map = {},
    })

    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

    -- Code action
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

    -- Rename
    keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

    -- Peek Definition
    -- you can edit the definition file in this flaotwindow
    -- also support open/vsplit/etc operation check definition_action_keys
    -- support tagstack C-t jump back
    keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

    -- Show line diagnostics
    keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

    -- Show cursor diagnostic
    keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

    -- Diagnsotic jump can use `<c-o>` to jump back
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

    -- Only jump to error
    keymap("n", "[E", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    keymap("n", "]E", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })

    -- Outline
    keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

    -- Hover Doc
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

    -- Float terminal
    keymap("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
    -- if you want pass somc cli command into terminal you can do like this
    -- open lazygit in lspsaga float terminal
    keymap("n", "<A-g>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
    -- close floaterm
    keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end
