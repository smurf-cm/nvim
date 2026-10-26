--
-- ~/.config/nvim/lua/plugins/nvim_tree.lua
--

return function()
    local tree = require("nvim-tree")
    local api = require("nvim-tree.api")

    tree.setup({
        view = {
            side = "left",
            width = 40,
        },

        renderer = {
            group_empty = false,
            indent_markers = {
                enable = true,
            },
        },

        update_focused_file = {
            enable = true,
        },

        filters = {
            dotfiles = false,
            custom = {
                "^__pycache__$",
                "^%.venv$",
                "^node_modules$",
            },
        },

        git = {
            enable = true,
        },
    })

    vim.keymap.set("n", "<leader>e", api.tree.toggle, {
        desc = "Toggle file tree",
    })

    vim.keymap.set("n", "<leader>E", function()
        api.tree.find_file({
            open = true,
            focus = true,
        })
    end, {
        desc = "Reveal current file in tree",
    })
end
