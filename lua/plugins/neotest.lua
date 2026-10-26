require("neotest").setup({
    adapters = {
        require("neotest-python")({
            runner = "pytest",
            args = {
                "-q",
                "--no-cov",
            },
            python = ".venv/bin/python",
        }),
    },

    output = {
        open_on_run = true,
    },
})

vim.keymap.set("n", "<leader>tt", function()
    require("neotest").run.run()
end, {
    desc = "Run nearest test",
})

vim.keymap.set("n", "<leader>tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
end, {
    desc = "Run tests in current file",
})

vim.keymap.set("n", "<leader>ta", function()
    require("neotest").run.run(vim.fn.getcwd())
end, {
    desc = "Run all tests",
})

vim.keymap.set("n", "<leader>ts", function()
    require("neotest").summary.toggle()
end, {
    desc = "Toggle test summary",
})

vim.keymap.set("n", "<leader>to", function()
    require("neotest").output.open()
end, {
    desc = "Open last test output",
})
