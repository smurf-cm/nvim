local lint = require("lint")

lint.linters_by_ft = {
    python = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("nvim_lint", {
        clear = true,
    }),
    callback = function()
        lint.try_lint()
    end,
})
