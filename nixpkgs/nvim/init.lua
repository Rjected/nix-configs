-- Neovim Configuration in Lua
-- Modernized from Vimscript

-- Add the config directory to runtime path
local config_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
vim.opt.rtp:prepend(config_path)

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Don't enable filetype here - let Neovim handle it naturally




-- Options
local opt = vim.opt
opt.bomb = true
opt.binary = true
opt.ttyfast = true
opt.backspace = { "indent", "eol", "start" }
opt.tabstop = 4
opt.softtabstop = 0
opt.shiftwidth = 4
opt.expandtab = true
opt.hidden = true
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.backup = false
opt.swapfile = false
opt.fileformats = { "unix", "dos", "mac" }
opt.shell = vim.env.SHELL or "/bin/sh"
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.background = "dark"
opt.mousemodel = "popup"
opt.termguicolors = true
opt.scrolloff = 3
opt.laststatus = 2
opt.modeline = true
opt.modelines = 10
opt.title = true
opt.titleold = "Terminal"
opt.titlestring = "%F"
opt.statusline = "%F%m%r%h%w%=(%{&ff}/%Y) (line %l/%L, col %c)"
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.shortmess:append("c")
opt.updatetime = 2000
opt.wrap = true
opt.textwidth = 80
opt.colorcolumn = "0"
opt.clipboard = "unnamed,unnamedplus"

-- Fix terminal colors
if vim.env.TERM == "alacritty" then
  vim.env.TERM = "xterm-256color"
end

if vim.fn.has("gui_running") == 0 then
  vim.g.CSApprox_loaded = 1
end

-- Plugin configuration
require("lazy").setup({
  -- Fuzzy finder
  {
    "junegunn/fzf",
    build = ":call fzf#install()",
  },

  -- LSP
  "neovim/nvim-lspconfig",
  "nvim-lua/lsp-status.nvim",
  "ray-x/lsp_signature.nvim",

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "onsails/lspkind.nvim",

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
  "rafamadriz/friendly-snippets",

  -- UI and Themes
  "chrisbra/Colorizer",
  "rebelot/kanagawa.nvim",
  "AlessandroYorba/alduin",
  "AlessandroYorba/sierra",
  "sainnhe/everforest",
  "tjdevries/colorbuddy.nvim",
  "jesseleite/nvim-noirbuddy",

  -- Navigation and File Management
  "scrooloose/nerdtree",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
  },

  -- Git
  "tpope/vim-fugitive",
  "ruanyl/vim-gh-line",
  "airblade/vim-gitgutter",
  "sindrets/diffview.nvim",
  "pwntester/octo.nvim",

  -- Editing
  "tpope/vim-commentary",
  "tpope/vim-surround",
  "Raimondi/delimitMate",
  "ggandor/leap.nvim",
  "mg979/vim-visual-multi",
  "ntpeters/vim-better-whitespace",
  "Yggdroot/indentLine",

  -- Language specific
  "hwayne/tla.vim",
  "lervag/vimtex",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- UI enhancements
  "kyazdani42/nvim-web-devicons",
  "ryanoasis/vim-devicons",
  "folke/trouble.nvim",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "MunifTanjim/nui.nvim",
  "shortcuts/no-neck-pain.nvim",
  "tomasky/bookmarks.nvim",

  -- Session management
  "xolox/vim-misc",
  "xolox/vim-session",

  -- AI
  "github/copilot.vim",
  {
    "yetone/avante.nvim",
    branch = "main",
    build = "make",
  },
  "zbirenbaum/copilot.lua",

  -- Other tools
  "stevearc/dressing.nvim",
  "MeanderingProgrammer/render-markdown.nvim",
  "HakonHarnes/img-clip.nvim",
  "kraftwerk28/gtranslate.nvim",
  "t-troebst/perfanno.nvim",
  {
    "ray-x/guihua.lua",
    build = "cd lua/fzy && make",
  },
  "p00f/godbolt.nvim",
  "edluffy/hologram.nvim",

  -- Utility
  "avelino/vim-bootstrap-updater",
  {
    "Shougo/vimproc.vim",
    build = vim.g.make or "make",
  },
}, {
  -- Lazy.nvim options
  defaults = {
    lazy = false,  -- Don't lazy load by default
  },
  performance = {
    rtp = {
      reset = false,  -- Don't reset runtimepath
    },
  },
})

-- Enable filetype detection after lazy setup
vim.cmd("filetype plugin indent on")

-- Set colorscheme after plugins load
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    -- Load configurations after plugins are loaded
    require("config.keymaps")
    require("config.autocmds")
    require("config.lsp")
    require("config.completion")
    require("config.telescope")
    require("config.plugins")
    
    -- Set colorscheme
    pcall(vim.cmd, "colorscheme kanagawa-lotus")
  end,
})