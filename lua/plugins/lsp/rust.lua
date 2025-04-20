--
-- ~/.config/nvim/lua/plugins/lsp/rust.lua
--
local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})
