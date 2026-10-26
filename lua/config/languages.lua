--
-- ~/.config/nvim/lua/config/languages.lua
--

local M = {}

M.treesitter = {
    "lua",
    "rust",
    "python",
    "bash",
    "toml",
    "json",
    "yaml",
}

M.close_fold_kinds_for_ft = {
    default = {
        "imports",
        "comment",
    },

    python = {
        "import_statement",
        "import_from_statement",
        "class_definition",
        "function_definition",
    },

    rust = {
        "use_declaration",
        "mod_item",
        "struct_item",
        "impl_item",
        "function_item",
    },
}

return M
