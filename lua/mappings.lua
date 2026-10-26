--
-- ~/.config/nvim/lua/mappings.lua
--

local function safe_del(mode, lhs)
    pcall(vim.keymap.del, mode, lhs)
end

local opts = { noremap = true, silent = true }

--
-- Save normal file buffers only
--
local function save_file()
    if vim.bo.buftype ~= ""
        or vim.bo.readonly
        or not vim.bo.modifiable
        or vim.api.nvim_buf_get_name(0) == ""
    then
        return
    end

    vim.cmd("write")
end

--
-- Global mappings
--
vim.keymap.set("n", "<leader>w", save_file, {
    desc = "Save file",
})

vim.keymap.set({ "n", "i", "v" }, "<C-s>", save_file, {
    desc = "Save file",
})

vim.keymap.set("i", "<C-s><C-s>", save_file, {
    desc = "Save and continue editing",
})

vim.api.nvim_create_autocmd("FocusLost", {
    group = vim.api.nvim_create_augroup("save_on_focus_lost", {
        clear = true,
    }),
    callback = function()
        if vim.bo.modified then
            save_file()
        end
    end,
})

--
-- Window navigation
--
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

--
-- Folding
--
vim.keymap.set("n", "<leader>c", "zc", {
    desc = "Close current and enclosing folds",
})

vim.keymap.set("n", "<leader>o", "zO", {
    desc = "Unfold current scope",
})

--
-- Unbind keys for tmux
--
safe_del("n", "<C-n>")
safe_del("n", "<C-p>")
safe_del("i", "<C-n>")
safe_del("i", "<C-p>")

--
-- LSP navigation
--
local function lsp_jump_split(split_cmd)
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(
        0,
        "textDocument/definition",
        params,
        function(err, result, ctx, config)
            if err or not result or vim.tbl_isempty(result) then
                print("Definition not found")
                return
            end

            local location = vim.islist(result) and result[1] or result

            vim.cmd(split_cmd)
            vim.lsp.util.jump_to_location(location, "utf-8")
        end
    )
end

vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {
    desc = "LSP definition",
})

vim.keymap.set("n", "<leader>vd", function()
    lsp_jump_split("vsplit")
end, {
    desc = "LSP definition in vertical split",
})

vim.keymap.set("n", "<leader>hd", function()
    lsp_jump_split("split")
end, {
    desc = "LSP definition in horizontal split",
})

--
-- Diagnostics
--
vim.keymap.set("n", "<leader>f", function()
    vim.diagnostic.open_float(nil, { focus = false })
end, {
    desc = "Show diagnostic",
})

--
-- Telescope
--
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

--
-- File tree
--
vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeToggle<CR>", {
    silent = true,
    desc = "Toggle file tree",
})

vim.keymap.set("n", "<leader>fE", "<cmd>NvimTreeFindFile<CR>", {
    silent = true,
    desc = "Reveal current file in tree",
})

--
-- Terminal
--
vim.keymap.set(
    "n",
    "<leader>ft",
    ":botright split | terminal<CR>i",
    { desc = "Full-width bottom terminal" }
)

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("terminal_keymaps", {
        clear = true,
    }),
    pattern = "term://*",
    callback = function(args)
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
            buffer = args.buf,
            desc = "Exit terminal mode",
        })
    end,
})

vim.keymap.set("n", "<leader>th", function()
    local height = math.floor(vim.o.lines * 0.25)

    require("toggleterm.terminal").Terminal:new({
        direction = "horizontal",
        size = height,
    }):toggle()
end, {
    desc = "Toggle horizontal terminal",
})

vim.keymap.set("n", "<leader>tv", function()
    local width = math.max(
        math.floor(vim.fn.winwidth(0) * 0.4),
        60
    )

    require("toggleterm.terminal").Terminal:new({
        direction = "vertical",
        size = width,
    }):toggle()
end, {
    desc = "Toggle vertical terminal",
})
