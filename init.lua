--
-- ~/.config/nvim/init.lua
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("plugins")
require("mappings")
require("options")
require("themes")
require("autocmds")
require("config")
