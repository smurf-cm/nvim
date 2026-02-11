--
-- ~/.config/nvim/lua/config/clipboard.lua
--
--

vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.has("wsl") == 1 then
            vim.api.nvim_create_autocmd("TextYankPost", {
                group = vim.api.nvim_create_augroup("Yank", { clear = true }),
                callback = function()
                    if vim.v.event.operator == "y" and vim.v.event.regname == "" then
                        vim.fn.system("clip.exe", vim.fn.getreg('"'))
                    end
                end,
            })
        end
    end
})
