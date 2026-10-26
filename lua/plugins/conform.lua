local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
        rust = { "rustfmt" },
        lua = { "stylua" },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    conform.format({
        async = true,
        lsp_format = "fallback",
    })
end, {
    desc = "Format buffer",
})
