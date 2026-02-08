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
    layout_strategy = "current_buffer",
}

return M
