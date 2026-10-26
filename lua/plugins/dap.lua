--
-- ~/.config/nvim/lua/plugins/dap.lua
--

local dap = require("dap")

vim.keymap.set("n", "<leader>db", function()
    dap.toggle_breakpoint()
end, {
    desc = "Toggle breakpoint",
})

vim.keymap.set("n", "<leader>dc", function()
    dap.continue()
end, {
    desc = "Start or continue debugging",
})

vim.keymap.set("n", "<leader>do", function()
    dap.step_over()
end, {
    desc = "Step over",
})

vim.keymap.set("n", "<leader>di", function()
    dap.step_into()
end, {
    desc = "Step into",
})

vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle()
end, {
    desc = "Toggle debugging UI",
})
