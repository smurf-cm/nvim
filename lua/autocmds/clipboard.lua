--
-- ~/.config/nvim/lua/autocmds/clipboard.lua
--
-- Clipboard configuration for WSL, Wayland, X11, and headless/SSH sessions.
--

local is_wsl = vim.fn.has("wsl") == 1

local is_wayland = vim.env.WAYLAND_DISPLAY ~= nil
    and vim.fn.executable("wl-copy") == 1
    and vim.fn.executable("wl-paste") == 1

local is_x11 = vim.env.DISPLAY ~= nil
    and vim.fn.executable("xclip") == 1

if is_wsl then
    --
    -- WSL: use the Windows clipboard.
    --
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
    --
    -- Native Linux with Wayland.
    --
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
    --
    -- Native Linux with X11.
    --
    vim.g.clipboard = {
        name = "xclip-clipboard",

        copy = {
            ["+"] = { "xclip", "-quiet", "-selection", "clipboard" },
            ["*"] = { "xclip", "-quiet", "-selection", "primary" },
        },

        paste = {
            ["+"] = { "xclip", "-o", "-selection", "clipboard" },
            ["*"] = { "xclip", "-o", "-selection", "primary" },
        },

        cache_enabled = 0,
    }

    vim.opt.clipboard = "unnamedplus"

else
    --
    -- SSH, headless environments, or systems without a supported
    -- clipboard provider.
    --
    -- Keep Neovim's internal clipboard only.
    vim.opt.clipboard = ""
end
