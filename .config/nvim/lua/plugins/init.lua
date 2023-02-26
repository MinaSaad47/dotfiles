return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- lsp progress status
            "j-hui/fidget.nvim",

            -- inlayhints
            "lvimuser/lsp-inlayhints.nvim",
        },
    },
    "windwp/nvim-autopairs",
}
