--
-- ~/.config/nvim/lua/plugins/lsp/mason.lua
--
--
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pylyzer",
    },
    automatic_installation = true,  -- Automatically install missing servers
})
