-- ~/.config/nvim/lua/plugins/lsp/mason.lua
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",        -- Lua language server
        "rust_analyzer", -- Rust language server
    },
    automatic_installation = true,
})
