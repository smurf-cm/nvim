--
-- ~/.config.nvim/lua/autocmds/file_browser.lua
--
--

local function launch_file_browser(directory)
    vim.cmd("cd " .. directory)
    vim.schedule(function()
        local config = require("config.telescope_file_browser").config

        require("telescope").load_extension("file_browser")
        require("telescope").extensions.file_browser.file_browser(config)
    end)
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local arg = vim.fn.argv(0)

        if vim.fn.empty(arg) == 1 then
            launch_file_browser(vim.fn.getcwd())

        elseif vim.fn.isdirectory(arg) == 1 then
            launch_file_browser(arg)
        end
    end,
})
