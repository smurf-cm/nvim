--
-- ~/.config/nvim/lua/plugins/ufo.lua
--

return function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require("ufo").setup({
        provider_selector = function()
            return { "treesitter", "indent" }
        end,

        close_fold_kinds_for_ft = {
            default = { "imports", "comment" },
            python = {
                "import_statement",
                "import_from_statement",
                "class_definition",
                "function_definition",
            },
        },
    })

    vim.keymap.set("n", "zR", require("ufo").openAllFolds, {
        desc = "Open all folds",
    })

    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, {
        desc = "Close all folds",
    })
end
