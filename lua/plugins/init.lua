--
-- ~/.config/nvim/lua/plugins/init.lua
--
--

install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd("packadd packer.nvim")
end

vim.cmd("packadd packer.nvim")

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins/init.lua source <afile> | PackerSync
augroup end
]])

require("packer").startup(function(use)
    use { "wbthomason/packer.nvim" }

    use { "neovim/nvim-lspconfig", config = require("plugins.lsp") }
    use { "nvim-telescope/telescope.nvim", config = require("plugins.telescope") }
    use { "nvim-treesitter/nvim-treesitter", config = require("plugins.treesitter") }
    use { "lewis6991/gitsigns.nvim", config = require("plugins.gitsigns") }
    use { "nvim-telescope/telescope-file-browser.nvim", requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } }
    use { "akinsho/toggleterm.nvim", tag = "*", config = require("toggleterm").setup() }
    use { "eldritch-theme/eldritch.nvim" }
    -- use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }, config = require('lualine').get_config() }
    --
    use { "williamboman/mason.nvim", config = require("plugins.mason") }
    use { "williamboman/mason-lspconfig.nvim" }

    use { "nvim-lua/plenary.nvim" }
end)
