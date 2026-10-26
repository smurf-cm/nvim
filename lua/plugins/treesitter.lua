--
-- ~/.config/nvim/lua/plugins/treesitter.lua
--
--

return function()
    local languages = require("config.languages").treesitter

    require("nvim-treesitter").install(languages)

    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        pattern = languages,
        callback = function(args)
            vim.treesitter.start(args.buf)
        end,
    })
end
