-- Plugin configurations

-- Neo-tree file explorer
require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      default = "*",
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "󰁕",
        untracked = "",
        ignored   = "",
        unstaged  = "󰄱",
        staged    = "",
        conflict  = "",
      }
    },
  },
  window = {
    position = "left",
    width = 30,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = { 
        "toggle_node", 
        nowait = false,
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel",
      ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["Z"] = "expand_all_nodes",
      ["R"] = "refresh",
      ["a"] = { "add", config = { show_path = "relative" } },
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["e"] = "toggle_auto_expand_width",
      ["q"] = "close_window",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
      ["i"] = "show_file_details",
    }
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
      hide_by_name = {
        ".DS_Store",
        "thumbs.db",
        "node_modules",
        "target"
      },
    },
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
    group_empty_dirs = false,
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = true,
  },
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
    group_empty_dirs = true,
    show_unloaded = true,
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"]  = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      }
    }
  },
})

-- Trouble
require("trouble").setup({})

-- Avante AI assistant (optional - uncomment to use)
-- require("avante_lib").load()
-- require("avante").setup({
--   provider = "gemini",
--   providers = {
--     gemini = {
--       endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
--       model = "gemini-2.5-pro-preview-03-25",
--       timeout = 30000,
--       temperature = 0,
--       max_tokens = 1048576,
--     },
--   },
-- })

-- Sidekick AI assistant (disabled - see lua/config/sidekick_backup.lua)
-- To enable sidekick:
-- 1. Comment out minuet in init.lua
-- 2. Uncomment sidekick in init.lua
-- 3. Uncomment the Copilot LSP setup in lsp.lua
-- 4. Uncomment the configuration below
-- require("sidekick").setup({
--   -- Configuration moved to sidekick_backup.lua
-- })

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
-- Keymaps are now defined in keymaps.lua instead of using deprecated add_default_mappings()

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

-- Diffview
require("diffview").setup({
  enhanced_diff_hl = true,
  view = {
    default = {
      layout = "diff2_horizontal",
    },
    merge_tool = {
      layout = "diff3_horizontal",
      disable_diagnostics = true,
    },
    file_history = {
      layout = "diff2_horizontal",
    },
  },
  file_panel = {
    listing_style = "tree",
    tree_options = {
      flatten_dirs = true,
      folder_statuses = "only_folded",
    },
  },
  keymaps = {
    view = {
      ["<tab>"] = require("diffview.actions").select_next_entry,
      ["<s-tab>"] = require("diffview.actions").select_prev_entry,
      ["gf"] = require("diffview.actions").goto_file_tab,
      ["<C-w><C-f>"] = require("diffview.actions").goto_file_split,
      ["<C-w>gf"] = require("diffview.actions").goto_file,
      ["<leader>e"] = require("diffview.actions").focus_files,
      ["<leader>b"] = require("diffview.actions").toggle_files,
    },
  },
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

