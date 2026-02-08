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

    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim", after = "mason.nvim"}

    use { "nvim-lua/plenary.nvim" }

    use {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("plugins.telescope")()
        end
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.treesitter")
        end
    }

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        wants = {"nvim-telescope/telescope.nvim"},
        config = function()
            require("telescope").load_extension("file_browser")
        end
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("toggleterm").setup()
        end
    }

    use { "eldritch-theme/eldritch.nvim" }

    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "L3MON4D3/LuaSnip" }
    use { "saadparwaiz1/cmp_luasnip" }

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("plugins.cmp")
        end
    }

    use {
        "MeanderingProgrammer/markdown.nvim",
        ft = "markdown",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup()
            vim.keymap.set("n", "<leader>mp", function()
                require("render-markdown").toggle()
            end, { desc = "Toggle Markdown Preview" })
        end
    }
end)

