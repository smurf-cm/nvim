--
-- ~/.config/nvim/lua/autocmds/lsp.lua
--
--
local capabilities = require("config.cmp").capabilities()

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("PostStartup", { clear = true }),
    callback = function()
        require("lsp.mason")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua" },
    callback = function()
        local lua = require("lsp.lua").settings
        vim.lsp.start({
            name = "lua_ls",
            cmd = { "lua-language-server" },
            root_dir = vim.fn.getcwd(),
            capabilities = capabilities,
            settings = lua.settings,
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rust" },
    callback = function()
        local rust = require("lsp.rust").settings
        vim.lsp.start({
            name = "rust_analyzer",
            cmd = { "rust-analyzer" },
            root_dir = vim.fn.getcwd(),
            capabilities = capabilities,
            settings = rust.settings
        })

    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
        local python = require("lsp.python").settings
        vim.lsp.start({
            name = "pylyzer",
            cmd = { "pylyzer", "--server" },
            root_dir = vim.fn.getcwd(),
            capabilities = capabilities,
            settings = python.settings,
        })

    end,
})
