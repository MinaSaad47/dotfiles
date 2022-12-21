-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
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

packer.startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- lsp progress status
      "j-hui/fidget.nvim",

      -- inlayhints
      "lvimuser/lsp-inlayhints.nvim",
    },
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",

      -- better ui
      { "glepnir/lspsaga.nvim", branch = "main" },
    },
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
    requires = {
      "p00f/nvim-ts-rainbow",
    },
  }
  use { -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }

  -- file explorer
  use "kyazdani42/nvim-tree.lua"
  -- ui icons
  use "kyazdani42/nvim-web-devicons"
  -- status line
  use "nvim-lualine/lualine.nvim"
  -- language server
  use {
    "jose-elias-alvarez/null-ls.nvim",
  }

  use "lewis6991/gitsigns.nvim"

  -- telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- autopair
  use "windwp/nvim-autopairs"

  use "ellisonleao/gruvbox.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "romgrk/barbar.nvim"

  -- flutter-tools
  use "akinsho/flutter-tools.nvim"

  if is_bootstrap then
    require("packer").sync()
  end
end)

if is_bootstrap then
  print "=================================="
  print "    Plugins are being installed"
  print "    Wait until Packer completes,"
  print "       then restart nvim"
  print "=================================="
  return
end

-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print "=================================="
  print "    Plugins are being installed"
  print "    Wait until Packer completes,"
  print "       then restart nvim"
  print "=================================="
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand "$MYVIMRC",
})
