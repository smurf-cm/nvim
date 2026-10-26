--
-- ~/.config/nvim/lua/autocmds/clipboard.lua
--

local is_wsl = vim.fn.has("wsl") == 1

local is_wayland = vim.env.WAYLAND_DISPLAY ~= nil
    and vim.fn.executable("wl-copy") == 1
    and vim.fn.executable("wl-paste") == 1

local is_x11 = vim.env.DISPLAY ~= nil
    and vim.fn.executable("xsel") == 1

if is_wsl then
    vim.g.clipboard = {
        name = "WslClipboard",

        copy = {
            ["+"] = { "clip.exe" },
            ["*"] = { "clip.exe" },
        },

        paste = {
            ["+"] = {
                "powershell.exe",
                "-NoProfile",
                "-Command",
                '[Console]::Out.Write((Get-Clipboard -Raw).Replace("`r", ""))',
            },
            ["*"] = {
                "powershell.exe",
                "-NoProfile",
                "-Command",
                '[Console]::Out.Write((Get-Clipboard -Raw).Replace("`r", ""))',
            },
        },

        cache_enabled = 0,
    }

    vim.opt.clipboard = "unnamedplus"
elseif is_wayland then
    vim.g.clipboard = {
        name = "wl-clipboard",

        copy = {
            ["+"] = { "wl-copy", "--type", "text/plain" },
            ["*"] = { "wl-copy", "--primary", "--type", "text/plain" },
        },

        paste = {
            ["+"] = { "wl-paste", "--no-newline" },
            ["*"] = { "wl-paste", "--no-newline", "--primary" },
        },

        cache_enabled = 0,
    }

    vim.opt.clipboard = "unnamedplus"
elseif is_x11 then
    vim.g.clipboard = {
        name = "xsel-clipboard",

        copy = {
            ["+"] = { "xsel", "-ib", "--nodetach" },
            ["*"] = { "xsel", "-ip", "--nodetach" },
        },

        paste = {
            ["+"] = { "xsel", "-ob", "--nodetach" },
            ["*"] = { "xsel", "-op", "--nodetach" },
        },

        cache_enabled = 1,
    }

    vim.opt.clipboard = "unnamedplus"
else
    vim.g.loaded_clipboard_provider = 1
    vim.opt.clipboard = ""
end
