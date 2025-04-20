--
-- ~/.config/nvim/lua/plugins/lsp/rust.lua
--
--

local M = {}

M.settings = {
    cmd = { "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
            inlayHints = {
                enable = true
            },
            completion = {
                autoimport = {
                    enable = true
                }
            }
        },
    },
}

return M
