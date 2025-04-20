--
-- ~/.config/nvim/lua/plugins/lsp/lua.lua
--

local M = {}

M.settings = {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

return M
