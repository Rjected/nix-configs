-- Autocommands configuration

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Sync syntax from start
augroup("vimrc-sync-fromstart", { clear = true })
autocmd("BufEnter", {
  group = "vimrc-sync-fromstart",
  command = "syntax sync maxlines=200",
})

-- Remember cursor position
augroup("vimrc-remember-cursor-position", { clear = true })
autocmd("BufReadPost", {
  group = "vimrc-remember-cursor-position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Make/CMake settings
augroup("vimrc-make-cmake", { clear = true })
autocmd("FileType", {
  group = "vimrc-make-cmake",
  pattern = "make",
  command = "setlocal noexpandtab",
})
autocmd({ "BufNewFile", "BufRead" }, {
  group = "vimrc-make-cmake",
  pattern = "CMakeLists.txt",
  command = "setlocal filetype=cmake",
})

-- Filetype specific settings
augroup("filetype_settings", { clear = true })

-- Programming languages
autocmd("FileType", {
  group = "filetype_settings",
  pattern = { "cpp", "c", "go" },
  command = "setlocal tw=80",
})

-- Text files
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "tex",
  command = "setlocal spell tw=80",
})
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "text",
  command = "setlocal spell tw=72",
})
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "markdown",
  command = "setlocal spell tw=0",
})

-- EVM Assembly
autocmd({ "BufRead", "BufNewFile" }, {
  group = "filetype_settings",
  pattern = { "*.eas", "*.evm", "*.evmasm" },
  command = "setfiletype evmasm",
})
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "evmasm",
  command = "setlocal commentstring=;\\ %s",
})

-- LSP diagnostics
autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

autocmd("CursorHoldI", {
  callback = function()
    -- Only call signature_help if a server supports it
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.server_capabilities.signatureHelpProvider then
        vim.lsp.buf.signature_help()
        return
      end
    end
  end,
})

-- Inlay hints highlighting
autocmd("ColorScheme", {
  callback = function()
    -- Set up highlight groups for inlay hints - subtle gray, no background
    vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#8a8a8a", italic = true })
  end,
})
-- Apply immediately for current colorscheme
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#8a8a8a", italic = true })

-- Disable visual bell
autocmd("GUIEnter", {
  command = "set visualbell t_vb=",
})


-- Session settings
vim.g.session_directory = "~/.vim/session"
vim.g.session_autoload = "no"
vim.g.session_autosave = "no"
vim.g.session_command_aliases = 1

-- Better whitespace settings
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1

-- Vimtex settings
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_automatic = 1
vim.g.tex_conceal = "abdmg"

-- Neo-tree auto-open on startup
augroup("neo-tree-autoopen", { clear = true })
autocmd("VimEnter", {
  group = "neo-tree-autoopen",
  callback = function()
    -- Only open if no file arguments were passed
    if vim.fn.argc() == 0 then
      vim.cmd("Neotree filesystem reveal left")
    end
  end,
})

-- Vimshell settings
vim.g.vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
vim.g.vimshell_prompt = "$ "

-- IndentLine settings
vim.g.indentLine_enabled = 1
vim.g.indentLine_char = "┆"
vim.g.indentLine_faster = 1

-- Airline settings
-- Default to kanagawa-lotus theme (matches the colorscheme in init.lua)
vim.g.airline_theme = "kanagawa_lotus"
vim.g["airline#extensions#branch#enabled"] = 1
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g.airline_skip_empty_sections = 1

-- Add Copilot status to airline
vim.g.airline_section_x = "%{get(b:, 'copilot_status', '')}"

-- Airline symbols
if not vim.g.airline_symbols then
  vim.g.airline_symbols = {}
end

if not vim.g.airline_powerline_fonts then
  vim.g["airline#extensions#tabline#left_sep"] = " "
  vim.g["airline#extensions#tabline#left_alt_sep"] = "|"
  vim.g.airline_left_sep = ""
  vim.g.airline_left_alt_sep = "»"
  vim.g.airline_right_sep = ""
  vim.g.airline_right_alt_sep = "«"
  vim.g["airline#extensions#branch#prefix"] = "⎇"
  vim.g["airline#extensions#readonly#symbol"] = ""
  vim.g["airline#extensions#linecolumn#prefix"] = "¶"
  vim.g["airline#extensions#paste#symbol"] = "ρ"
  vim.g.airline_symbols.linenr = "␤"
  vim.g.airline_symbols.maxlinenr = ""
  vim.g.airline_symbols.branch = "⎇"
  vim.g.airline_symbols.paste = "∥"
  vim.g.airline_symbols.whitespace = "Ξ"
else
  vim.g["airline#extensions#tabline#left_sep"] = ""
  vim.g["airline#extensions#tabline#left_alt_sep"] = ""
  vim.g.airline_left_sep = ""
  vim.g.airline_left_alt_sep = ""
  vim.g.airline_right_sep = ""
  vim.g.airline_right_alt_sep = ""
  vim.g.airline_symbols.branch = ""
  vim.g.airline_symbols.readonly = ""
  vim.g.airline_symbols.linenr = ""
end

-- GitHub line trace
vim.g.gh_trace = 1

-- Markdown settings
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

-- Auto-sync airline theme with colorscheme
augroup("airline_theme_sync", { clear = true })
autocmd("ColorScheme", {
  group = "airline_theme_sync",
  pattern = "kanagawa*",
  callback = function()
    local colorscheme = vim.g.colors_name
    if colorscheme == "kanagawa-lotus" then
      vim.g.airline_theme = "kanagawa_lotus"
    elseif colorscheme == "kanagawa-wave" then
      vim.g.airline_theme = "kanagawa_wave"
    elseif colorscheme == "kanagawa-dragon" then
      vim.g.airline_theme = "kanagawa_dragon"
    end
    -- Reload airline with new theme
    if vim.fn.exists(":AirlineRefresh") == 2 then
      vim.cmd("AirlineRefresh")
    end
  end,
})

-- Update Copilot status in statusline (disabled - for sidekick)
-- augroup("copilot_status_update", { clear = true })
-- autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
--   group = "copilot_status_update",
--   callback = function()
--     local ok, sidekick_status = pcall(require, "sidekick.status")
--     if ok then
--       local status = sidekick_status.get()
--       if status then
--         if status.busy then
--           vim.b.copilot_status = "🔄 Copilot"  -- Thinking
--         elseif status.kind == "Error" then
--           vim.b.copilot_status = "❌ Copilot"  -- Error
--         else
--           vim.b.copilot_status = "✅ Copilot"  -- Ready
--         end
--       else
--         vim.b.copilot_status = ""  -- Not active
--       end
--     end
--   end,
-- })




