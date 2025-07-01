-- Plugin configurations

-- Trouble
require("trouble").setup({})

-- Avante AI assistant
require("avante_lib").load()
require("avante").setup({
  provider = "gemini",
  providers = {
    gemini = {
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
      model = "gemini-2.5-pro-preview-03-25",
      timeout = 30000,
      temperature = 0,
      max_tokens = 1048576,
    },
  },
})

-- Octo (GitHub integration)
require("octo").setup()

-- Bookmarks
require("bookmarks").setup({
  save_file = vim.fn.expand("$HOME/.bookmarks"),
  keywords = {
    ["@t"] = "☑️ ",
    ["@w"] = "⚠️ ",
    ["@f"] = "⛏ ",
    ["@n"] = " ",
  },
})

-- Leap motion
require("leap").add_default_mappings()

-- Performance annotations
require("perfanno").setup()

-- No neck pain (centering)
require("no-neck-pain").setup({
  width = 200,
})

-- Treesitter
require("nvim-treesitter.configs").setup({
  -- Install only these parsers automatically
  ensure_installed = { 
    "bash", "c", "cpp", "css", "dockerfile", "go", "html", "java", 
    "javascript", "json", "lua", "markdown", "python", "rust", 
    "toml", "typescript", "vim", "vimdoc", "yaml", "tsx", "regex",
    "markdown_inline", "comment"
  },
  -- Don't automatically install missing parsers (set to false)
  auto_install = false,
  sync_install = false,
  highlight = {
    enable = true,
    -- Disable vim regex highlighting (use treesitter only)
    additional_vim_regex_highlighting = false,
    -- Disable highlighting for files larger than 100 KB
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  indent = {
    enable = true,
  },
  -- Enable incremental selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  -- Treesitter textobjects
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[a"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sn"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sp"] = "@parameter.inner",
      },
    },
  },
})

-- EVM Assembly Tree-sitter
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.evm_asm = {
  install_info = {
    url = "~/projects/evm-asm-lsp/crates/tree-sitter-evm-asm",
    files = { "src/parser.c" },
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "evmasm",
}

-- EVM Assembly filetype detection
vim.filetype.add({
  extension = {
    eas = "evmasm",
    evm = "evmasm",
    evmasm = "evmasm",
  },
})

-- Auto-enable Tree-sitter for EVM Assembly
vim.api.nvim_create_autocmd("FileType", {
  pattern = "evmasm",
  callback = function()
    vim.defer_fn(function()
      pcall(vim.cmd, "TSBufEnable highlight")
    end, 100)
  end,
})

-- Godbolt
require("godbolt").setup({
  languages = {
    cpp = { compiler = "g122", options = {} },
    c = { compiler = "cg122", options = {} },
    rust = { compiler = "r1650", options = {} },
  },
  quickfix = {
    enable = false,
    auto_open = false,
  },
  url = "https://godbolt.org",
})

-- Vimtex callback function
_G.ViewerCallback = function(self)
  self:forward_search(self.out())
end
vim.g.vimtex_view_zathura_hook_callback = "ViewerCallback"

-- Airline configuration
-- Ensure airline loads with correct settings
if vim.fn.exists('g:loaded_airline') == 0 then
  -- Force airline to load if it hasn't
  vim.cmd('runtime plugin/airline.vim')
end

-- Apply theme after airline is loaded
vim.defer_fn(function()
  if vim.g.colors_name == "kanagawa-lotus" then
    vim.g.airline_theme = "kanagawa_lotus"
  elseif vim.g.colors_name == "kanagawa-wave" then
    vim.g.airline_theme = "kanagawa_wave"
  elseif vim.g.colors_name == "kanagawa-dragon" then
    vim.g.airline_theme = "kanagawa_dragon"
  end
  if vim.fn.exists(":AirlineRefresh") == 2 then
    vim.cmd("AirlineRefresh")
  end
end, 100)

-- Bufferline
require("bufferline").setup({
  options = {
    mode = "buffers",
    themable = true, -- Allow theme colors
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "NERDTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      }
    },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  },
  highlights = {
    fill = {
      bg = { attribute = "bg", highlight = "Normal" },
    },
    background = {
      bg = { attribute = "bg", highlight = "Normal" },
    },
    buffer_selected = {
      bold = true,
      italic = false,
    },
  },
})