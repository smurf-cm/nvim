--
-- ~/.config/nvim/lua/autocmds/lsp.lua
--
--
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_caps = require("config.cmp").capabilities()

capabilities = vim.tbl_deep_extend("force", capabilities, cmp_caps)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
    }
)

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
        local root_dir = vim.fn.getcwd()
        local python_bin = vim.fn.exepath("python3")
        -- 1. JEDI: (Go-to-definition, Autocomplete)
        vim.lsp.start({
            name = "jedi_language_server",
            cmd = { "jedi-language-server" },
            root_dir = root_dir,
            capabilities = capabilities,
            init_options = {
                workspace = {
                    environmentPath = python_bin,
                },
            },
        })
        -- 2. RUFF: (Diagnostics/Red Lines)
        vim.lsp.start({
            name = "ruff",
            cmd = { "ruff", "server" },
            root_dir = root_dir,
            capabilities = capabilities,
            settings = {
                -- Add Ruff-specific rules here
                args = {},
            },
        })
    end,
})
