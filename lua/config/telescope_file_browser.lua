--
-- ~/.config/nvim/lua/config/telescope_file_browser.lua
--
--

local M = {}

M.config = {
    path = "%:p:h",
    select_buffer = true,
    initial_mode = "normal",
    hijack_netrw = true,
    hidden = { file_browser = true, folder_browser = true },
    -- layout_strategy = "current_buffer",
    layout_strategy = "vertical",
    layout_config = {
        width = { padding = 0 },
        height = { padding = 0 },
        preview_height = 0.6,
        preview_cutoff = 0,
        prompt_position = "bottom",
    },
}

return M
