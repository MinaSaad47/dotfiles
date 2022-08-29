local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- plenary (dependency for other plugins)
    use 'nvim-lua/plenary.nvim'
    -- colorscheme
    use 'ellisonleao/gruvbox.nvim'
    -- file explorer
    use 'kyazdani42/nvim-tree.lua'
    -- ui icons
    use 'kyazdani42/nvim-web-devicons'
    -- status line
    use 'nvim-lualine/lualine.nvim'
    -- language server
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        -- snipets
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    }
    -- autopair
    use 'windwp/nvim-autopairs'
    -- tree setter
    use { 'nvim-treesitter/nvim-treesitter',
        'p00f/nvim-ts-rainbow',
        run = ':TSUpdate'
    }
    -- telescope
    use 'nvim-telescope/telescope.nvim'
    -- gitsigns
    use 'lewis6991/gitsigns.nvim'
    -- flutter-tools
    use 'akinsho/flutter-tools.nvim'
    -- indentline
    use 'lukas-reineke/indent-blankline.nvim'
    -- barbar
    use 'romgrk/barbar.nvim'
    -- toggleterm
    use { 'akinsho/toggleterm.nvim', tag = 'v1.*' }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
