--
-- ~/.config/nvim/lua/mappings.lua
--
--
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save File" })

--
-- telescope
--
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

vim.keymap.set("n", "<leader>fe", function()
    local config = require("config.telescope_file_browser").config
    require("telescope").extensions.file_browser.file_browser(config)
end, opts)

--
-- toggleterm
--
function _G.set_terminal_keymaps()
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], {buffer = 0})
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.keymap.set("n", "<leader>th", function()
    local height = math.floor(vim.o.lines * 0.25)
    require("toggleterm.terminal").Terminal:new(
        {
            direction = "horizontal",
            size = height,
        }
    ):toggle()
end, { desc = "Toggle Horizontal Terminal" })

vim.keymap.set("n", "<leader>tv", function()
    --
    -- This calc dosen"t seem to be working, vertical split is small
    --
    local width = math.max(math.floor(vim.fn.winwidth(0) * 0.4), 60)
    require("toggleterm.terminal").Terminal:new(
        {
            direction = "vertical",
            size = width,
        }
    ):toggle()
end, { desc = "Toggle Vertical Terminal" })

--
-- lsp
--
vim.keymap.set("n", "<leader>f", function()
  vim.diagnostic.open_float(nil, { focus = false })
end)

