# Neovim

Neovim configuration using Packer.

## Dependencies

```sh
sudo pacman -S --needed neovim git ripgrep fd
```

Clipboard support:

```sh
sudo pacman -S --needed xsel
```

Optional language tools:

```sh
sudo pacman -S --needed tree-sitter tree-sitter-cli rust-analyzer \
    lua-language-server jedi-language-server ruff
```

## Install

```sh
./install.sh
```

Creates:

```text
~/.config/nvim -> ~/.local/config/nvim
```

## Plugin installation

Open Neovim and run:

```vim
:PackerSync
```

`nvim/plugin/packer_compiled.lua` is generated and ignored by Git.
