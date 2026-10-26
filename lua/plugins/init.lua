--
-- ~/.config/nvim/lua/plugins/init.lua
--

local install_path =
    vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

vim.cmd("packadd packer.nvim")

--
-- Keep Mason's binaries available before language servers start.
--
vim.env.PATH =
    vim.fn.stdpath("data") .. "/mason/bin:" .. (vim.env.PATH or "")

vim.cmd([[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins/init.lua source <afile> | PackerSync
augroup END
]])

require("packer").startup(function(use)
    --
    -- Plugin manager
    --
    use {
        "wbthomason/packer.nvim",
    }

    --
    -- Language server tooling
    --
    use {
        "williamboman/mason.nvim",
    }

    use {
        "williamboman/mason-lspconfig.nvim",
        after = "mason.nvim",
    }

    --
    -- Shared utilities
    --
    use {
        "nvim-lua/plenary.nvim",
    }

    --
    -- Telescope
    --
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            require("plugins.telescope")()

            pcall(function()
                require("telescope").load_extension("fzf")
            end)
        end,
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        after = "telescope.nvim",
        config = function()
            require("telescope").load_extension("file_browser")
        end,
    }

    --
    -- Treesitter
    --
    use {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        config = function()
            require("plugins.treesitter")()
        end,
    }

    --
    -- Formatting
    --
    use {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function()
            require("plugins.conform")
        end,
    }

    --
    -- Linting
    --
    use {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.lint")
        end,
    }

    --
    -- Debugging
    --
    use {
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.dap")
        end,
    }

    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        after = "nvim-dap",
        config = function()
            require("dapui").setup()
        end,
    }

    --
    -- Testing
    --
    use {
        "nvim-neotest/nvim-nio",
    }

    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
        },
        config = function()
            require("plugins.neotest")
        end,
    }

    use {
        "nvim-neotest/neotest-python",
    }

    --
    -- Rust
    --
    use {
        "mrcjkb/rustaceanvim",
        ft = { "rust" },
    }

    use {
        "Saecki/crates.nvim",
        ft = { "rust", "toml" },
        config = function()
            require("crates").setup()
        end,
    }

    --
    -- Keymap help
    --
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end,
    }

    --
    -- Diagnostics
    --
    use {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        config = function()
            require("trouble").setup()
        end,
    }

    --
    -- Git
    --
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    }

    use {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit" },
    }

    use {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewFileHistory",
        },
    }

    --
    -- File tree
    --
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("plugins.nvim_tree")()
        end,
    }

    --
    -- Terminal
    --
    use {
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("toggleterm").setup()
        end,
    }

    --
    -- Completion
    --
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
        end,
    }

    --
    -- Markdown rendering
    --
    use {
        "MeanderingProgrammer/markdown.nvim",
        ft = "markdown",
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("render-markdown").setup()

            vim.keymap.set("n", "<leader>mp", function()
                require("render-markdown").toggle()
            end, {
                desc = "Toggle Markdown Preview",
            })
        end,
    }

    --
    -- Code folding
    --
    use {
        "kevinhwang91/nvim-ufo",
        requires = {
            "kevinhwang91/promise-async",
        },
        config = function()
            require("plugins.ufo")()
        end,
    }

    --
    -- Mermaid
    --
    use {
        "kevalin/mermaid.nvim",
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("mermaid").setup()
        end,
    }

    --
    -- Themes
    --
    use {
        "eldritch-theme/eldritch.nvim",
    }

    use {
        "catppuccin/nvim",
        as = "catppuccin",
    }
end)
