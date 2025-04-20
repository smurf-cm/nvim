--
-- ~/.config/nvim/lua/plugins/treesitter.lua
--
--
return function()
    require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "rust", "python", "bash", "toml", "json", "yaml" },
        highlight = { enable = true },
        indent = { enable = true },
    }
end
