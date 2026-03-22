--
-- ~/.config/nvim/lua/plugins/lsp/rust.lua
--
--
local M = {}

M.settings = {
    ["rust-analyzer"] = {
        cargo = {
            allFeatures = true
        },
        checkOnSave = true,
        check = {
            command = "clippy",
        },
        inlayHints = {
            enable = true
        },
        completion = {
            autoimport = {
                enable = true
            }
        }
    },
}

return M
