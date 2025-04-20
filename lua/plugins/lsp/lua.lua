--
-- ~/.config/nvim/lua/plugins/lsp/lua.lua
--
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})
