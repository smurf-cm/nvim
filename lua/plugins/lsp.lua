--
-- ~/.config/nvim/lua/plugins/lsp.lua
--
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.lsp.lua")
            require("plugins.lsp.rust")
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        config = require("plugins.lsp.mason"),
    },
    {
        "williamboman/mason-lspconfig.nvim",
        after = "mason.nvim",
        config = true,
    },
}

