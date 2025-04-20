--
-- ~/.config/nvim/lua/plugins/nvimtree.lua
--
--
return function()
    require("nvim-tree").setup({
        view = {
            width = 30,
            side = "left",
        },
        renderer = {
            highlight_opened_files = "all",
        },
    })
end
