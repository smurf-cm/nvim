--
-- ~/.config/nvim/lua/plugins/lsp/python.lua
--
--
local M = {}

M.settings = {
  jedi_language_server = {
    completion = {
      disableSnippets = false,
    },
    diagnostics = {
      enable = true,
    },
  },
}

return M
