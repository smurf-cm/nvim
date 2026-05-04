--
-- ~/.config/nvim/lua/plugins/lsp/mason.lua
--
--
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "jedi_language_server",
    },
    automatic_installation = true,
})
