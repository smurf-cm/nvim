--
-- ~/.config/nvim/lua/plugins/testscope.lua
--
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
            find_files = { hidden = true, previewer = false, },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            file_browser = require("config.telescope_file_browser").config
        },
    }
    require("telescope").load_extension("fzf")
end
