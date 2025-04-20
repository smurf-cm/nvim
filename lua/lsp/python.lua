--
-- ~/.config/nvim/lua/plugins/lsp/python.lua
--
--
local M = {}

M.settings = {
  cmd = { "pylyzer" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}

return M
