--
-- ~/.config/nvim/lua/plugins/testscope.lua
--

return function()
    local actions = require("telescope.actions")

    require("telescope").setup{
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            mappings = {
                i = {
                    ["<C-h>"] = actions.which_key,
                },
            },
        },
        pickers = {
            find_files = {
                theme = "dropdown",
                hidden = true,
                previewer = false,
            },
            live_grep = {
                theme = "dropdown",
            },
            buffers = {
                theme = "dropdown",
            },
            help_tags = {
                theme = "dropdown",
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "ignore_case",
            },
            file_browser = {
                theme = "ivy",
                hijack_netrw = true,
                mappings = {},
                hidden = { file_browser = true, folder_browser = true },
            },

        },
    }

    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("fzf")
end
