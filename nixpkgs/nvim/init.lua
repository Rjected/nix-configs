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

-- Disable session auto-save/load prompts
vim.g.session_autoload = 'no'
vim.g.session_autosave = 'no'

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
opt.showmode = false  -- Disable mode display to avoid duplication
opt.cmdheight = 1     -- Ensure command line height is consistent
opt.modeline = true
opt.modelines = 10
opt.title = true
opt.titleold = "Terminal"
opt.titlestring = "%F"
opt.statusline = "%F%m%r%h%w%=(%{&ff}/%Y) (line %l/%L, col %c)"
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.shortmess:append("c")
opt.updatetime = 300  -- Reduced from 2000ms for faster AI completions
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
  
  -- Mason for managing LSP servers and DAP adapters
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 100,  -- Load early
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    lazy = false,
    config = function()
      -- Copilot Language Server installation (disabled - for sidekick)
      -- local mason_registry = require("mason-registry")
      -- if not mason_registry.is_installed("copilot-language-server") then
      --   vim.notify("Installing Copilot Language Server via Mason...", vim.log.levels.INFO)
      --   vim.cmd("MasonInstall copilot-language-server")
      -- end
      
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Add LSP servers you want here
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },

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
  -- "scrooloose/nerdtree",  -- Replaced with neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
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
  
  -- Local inline-reviews plugin for PR comments
  {
    dir = "~/projects/inline-reviews",
    name = "inline-reviews",
    config = function()
      require("inline-reviews").setup({
        auto_load = true,  -- Auto-detect PR on buffer enter
        notifications = false,  -- Disable "Loaded X comments" messages
        keymaps = {
          view_comments = "<leader>rc",
          next_comment = "]c",
          prev_comment = "[c",
        },
        -- Enable the statuscolumn integration
        statuscolumn = {
          enabled = true,  -- This is the key to enable it!
          component_position = "left",  -- or "right"
          show_count = true,
          show_outdated = true,
        },
        -- Custom icons for comment states
        icons = {
          resolved = "✓",     -- Green check for resolved
          unresolved = "●",   -- Filled circle for unresolved
          outdated = "○",     -- Empty circle for outdated
          pending = "◐",      -- Half circle for pending
        },
        -- Configure the picker to use split layout (optional)
        picker = {
          layout = "vsplit",  -- Try "vsplit" for sidebar, "split" for bottom, or "float" (default)
          split_width = 40,
          auto_close = false,  -- Keep picker open when navigating
          filters = {
            enabled = true,
            default = "status:unresolved",  -- Show only unresolved by default
          },
        }
      })
    end,
  },

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
    branch = "master",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },

  -- UI enhancements
  "kyazdani42/nvim-web-devicons",
  "ryanoasis/vim-devicons",
  "folke/trouble.nvim",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  "MunifTanjim/nui.nvim",
  "shortcuts/no-neck-pain.nvim",
  "tomasky/bookmarks.nvim",

  -- Session management
  {
    "xolox/vim-misc",
    lazy = false,
    priority = 100,
  },
  {
    "xolox/vim-session",
    dependencies = { "xolox/vim-misc" },
    lazy = false,
  },

  -- AI
  -- Amp.nvim - IDE integration for Amp CLI
  {
    "sourcegraph/amp.nvim",
    config = function()
      require("amp").setup()
    end,
  },
  
  -- Minuet AI (currently active)
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- CodeCompanion - chat/inline AI (Claude Code via ACP)
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  
  -- Avante (disabled)
  -- {
  --   "yetone/avante.nvim",
  --   branch = "main",
  --   build = "make",
  -- },
  
  -- Sidekick (disabled - config saved in lua/config/sidekick_backup.lua)
  -- {
  --   "folke/sidekick.nvim",
  --   dependencies = { 
  --     "nvim-lua/plenary.nvim",
  --   },
  --   event = "VeryLazy",
  --   opts = {},  -- Will be configured in plugins.lua
  -- },

  -- Snacks.nvim for experimental features
  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     require("snacks").setup({
  --       -- Enable experimental features
  --       bigfile = { enabled = true },
  --       notifier = { enabled = true },
  --       quickfile = { enabled = true },
  --       statuscolumn = { enabled = true },
  --       words = { enabled = true },
  --       styles = {
  --         notification = {
  --           wo = { wrap = true }
  --         }
  --       }
  --     })
  --   end,
  -- },

  -- Debug Adapter Protocol (DAP)
  "mfussenegger/nvim-dap",
  "nvim-neotest/nvim-nio",  -- Required for nvim-dap-ui
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-telescope/telescope-dap.nvim",
  "mfussenegger/nvim-dap-python",
  "leoluz/nvim-dap-go",
  "jbyuki/one-small-step-for-vimkind",  -- Lua debugging

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
    cache = {
      enabled = true,
    },
    rtp = {
      reset = false,  -- Don't reset runtimepath
    },
  },
  checker = {
    enabled = true,
    notify = false,
    frequency = 86400, -- Check once per day
  },
  ui = {
    border = "rounded",
  },
})

-- nvim-treesitter's legacy branch expects query directive matches to contain a
-- single TSNode per capture. Neovim 0.12 returns a list of nodes instead, which
-- breaks markdown injections with `attempt to call method 'range' (a nil value)`.
if vim.fn.has("nvim-0.12") == 1 then
  local query = require("vim.treesitter.query")
  local markdown_info_string_aliases = {
    ex = "elixir",
    pl = "perl",
    sh = "bash",
    ts = "typescript",
    uxn = "uxntal",
  }

  local function capture_node(match, id)
    local node = match[id]
    if type(node) == "table" then
      return node[1]
    end
    return node
  end

  local function parser_from_markdown_info_string(alias)
    return vim.filetype.match({ filename = "a." .. alias }) or markdown_info_string_aliases[alias] or alias
  end

  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = capture_node(match, pred[2])
    if not node then
      return
    end

    local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata["injection.language"] = parser_from_markdown_info_string(injection_alias)
  end, { force = true, all = false })
end

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
    require("config.minuet")  -- Minuet AI configuration
    require("config.codecompanion")  -- CodeCompanion (chat via Claude Code ACP)
    -- require("config.sidekick")  -- Sidekick (disabled - see sidekick_backup.lua)
    require("config.dap")
    
    -- Set colorscheme
    pcall(vim.cmd, "colorscheme kanagawa-lotus")
    
    -- Setup bufferline after colorscheme is loaded
    require("bufferline").setup({})
  end,
})
