# Neovim Configuration

This is a modern Lua-based Neovim configuration, migrated from Vimscript.

## Structure

```
nvim/
├── init.lua                 # Main configuration entry point
├── lua/
│   └── config/
│       ├── autocmds.lua     # Autocommands and global settings
│       ├── completion.lua   # nvim-cmp completion setup
│       ├── keymaps.lua      # Key mappings
│       ├── lsp.lua          # LSP configurations
│       ├── plugins.lua      # Plugin-specific configurations
│       └── telescope.lua    # Telescope and integrations
└── init.vim                 # Old Vimscript config (kept for reference)
```

## Installation

### Symlink Method (Recommended)

This keeps your configuration in the git repository while making it available to Neovim:

```bash
# Remove any existing Neovim config
rm -rf ~/.config/nvim

# Create symlink to this directory
ln -s ~/projects/nix-configs/nixpkgs/nvim ~/.config/nvim
```

Now you can edit files in either location:
- `~/.config/nvim/init.lua`
- `~/projects/nix-configs/nixpkgs/nvim/init.lua`

Both point to the same files.

### Direct Copy Method

If you prefer not to use symlinks:

```bash
cp -r ~/projects/nix-configs/nixpkgs/nvim ~/.config/nvim
```

## Features

- **Plugin Manager**: lazy.nvim (modern replacement for vim-plug)
- **LSP Support**: rust-analyzer, ccls, gopls, EVM assembly
- **Completion**: nvim-cmp with LSP integration
- **File Navigation**: Telescope, Harpoon, NERDTree
- **Git Integration**: fugitive, gitgutter, diffview, octo
- **AI Assistance**: GitHub Copilot, Avante (Gemini)
- **UI Enhancements**: Trouble, bookmarks, leap motion
- **Language Support**: Treesitter, various language plugins

## Key Mappings

Leader key: `,`

### File Navigation
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (Telescope)
- `<leader>fb` - Bookmarks
- `<F2>` - NERDTree find
- `<F3>` - NERDTree toggle

### LSP
- `K` - Hover documentation
- `gd` - Go to definition
- `gi` - Go to implementation
- `gr` - Find references
- `gn` - Rename symbol

### Git
- `<leader>gs` - Git status
- `<leader>gb` - Git blame
- `<leader>gc` - Git commit

### Buffers
- `<leader>c` - Close buffer
- `<leader>x` / `<leader>w` - Next buffer
- `<leader>z` / `<leader>q` - Previous buffer

## First Run

On first launch, lazy.nvim will automatically install all plugins. This may take a minute. You'll see a progress window showing the installation status.

## Troubleshooting

If you encounter module loading errors, ensure you've properly symlinked or copied the entire directory structure, not just individual files.