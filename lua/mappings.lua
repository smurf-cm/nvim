--
-- ~/.config/nvim/lua/mappings.lua
--
--
local function safe_del(mode, lhs)
  pcall(vim.keymap.del, mode, lhs)
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save File" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- unbind keys for tmux
safe_del("n", "<C-n>")
safe_del("n", "<C-p>")
safe_del("i", "<C-n>")
safe_del("i", "<C-p>")
--


--
-- LSP Navigation (Splits)
--
local function lsp_jump_split(split_cmd)
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
        if err or not result or vim.tbl_isempty(result) then
            print("Definition not found")
            return
        end

        local location = vim.islist(result) and result[1] or result
        vim.cmd(split_cmd)
        vim.lsp.util.jump_to_location(location, "utf-8")
    end)
end

-- Standard Definition jump
vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, { desc = "LSP Definition" })
-- spd for vertical split (matching your request)
vim.keymap.set("n", "<leader>vd", function() lsp_jump_split("vsplit") end, { desc = "LSP Definition Vertical Split" })
-- vsd for horizontal split (matching your request)
vim.keymap.set("n", "<leader>hd", function() lsp_jump_split("split") end, { desc = "LSP Definition Horizontal Split" })
--

--
-- Open a full-width horizontal terminal at the bottom
--
vim.keymap.set('n', '<leader>ft', ':botright split | terminal<CR>i', { desc = "Full-width bottom terminal" })

vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', function()
    vim.cmd('write')  -- :w
end, { desc = 'Save file' })

vim.keymap.set('i', '<C-s><C-s>', '<Esc>:w<CR>a', { desc = 'Save & continue insert' })

vim.api.nvim_create_autocmd('FocusLost', {
    callback = function() vim.cmd('silent! write') end
})

--

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

