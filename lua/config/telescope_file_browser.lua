--
-- ~/.config/nvim/lua/config/telescope_file_browser.lua
--
--

local M = {}

M.config = {
    path = "%:p:h",
    select_buffer = true,
    initial_mode = "normal",
}

return M
