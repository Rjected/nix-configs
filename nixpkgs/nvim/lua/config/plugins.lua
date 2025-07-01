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