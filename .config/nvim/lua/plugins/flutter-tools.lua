local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
end

return {
    "akinsho/flutter-tools.nvim",
    opts = {
        ui = {
            -- the border type to use for all floating windows, the same options/formats
            -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
            border = "rounded",
            -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
            -- please note that this option is eventually going to be deprecated and users will need to
            -- depend on plugins like `nvim-notify` instead.
        },
        decorations = {
            statusline = {
                -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
                -- this will show the current version of the flutter app from the pubspec.yaml file
                app_version = true,
                -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
                -- this will show the currently running device if an application was started with a specific
                -- device
                device = true,
            },
        },
        dev_log = {
            enabled = true,
            open_cmd = "20new", -- command to use to open the log buffer
        },
        widget_guides = {
            enabled = true,
        },
        lsp = {
            color = { -- show the derived colours for dart variables
                enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                background = true, -- highlight the background
                foreground = false, -- highlight the foreground
                virtual_text = true, -- show the hig:hlight using virtual text
                virtual_text_str = "■", -- the virtual text character to highlight
            },
            on_attach = on_attach,
        },
    },
    ft = "dart",
}
