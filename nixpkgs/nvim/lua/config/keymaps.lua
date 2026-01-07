-- Key mappings configuration

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Search centering
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Command abbreviations
vim.cmd([[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall
]])

-- Leap.nvim motion (replaces deprecated add_default_mappings)
map({'n', 'x', 'o'}, 's', '<Plug>(leap)')
map('n', 'S', '<Plug>(leap-from-window)')

-- Neo-tree
map("n", "<F2>", ":Neotree reveal<CR>", { silent = true })
map("n", "<F3>", ":Neotree toggle<CR>", { silent = true })
map("n", "<leader>e", ":Neotree filesystem reveal left<CR>", opts)
map("n", "<leader>be", ":Neotree buffers reveal float<CR>", opts)
map("n", "<leader>ge", ":Neotree git_status<CR>", opts)

-- Resize windows
map("n", "<leader>k", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<leader>j", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<leader>l", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- map("n", "<leader>h", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope bookmarks list<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", opts)
map("n", "<leader>fe", "<cmd>Telescope diagnostics<cr>", opts)
map("n", "<leader>fv", ":Telescope file_browser<CR>", opts)

-- Vimtex
map("n", "<Leader>tc", ":VimtexTocToggle<CR>", opts)
map("n", "<Leader>tv", ":VimtexTocOpen<CR>", opts)
map("n", "<Leader>lc", ":VimtexView<CR>", opts)

-- Splits
map("n", "<Leader>h", ":<C-u>split<CR>", opts)
map("n", "<Leader>v", ":<C-u>vsplit<CR>", opts)

-- Git
map("n", "<Leader>ga", ":Git write<CR>", opts)
map("n", "<Leader>gc", ":Git commit<CR>", opts)
map("n", "<Leader>gsh", ":Git push<CR>", opts)
map("n", "<Leader>gll", ":Git pull<CR>", opts)
map("n", "<Leader>gs", ":Git status<CR>", opts)
map("n", "<Leader>gb", ":Git blame<CR>", opts)
map("n", "<Leader>gr", ":Git remove<CR>", opts)

-- Diffview
map('n', '<leader><leader>v', function()
  if next(require("diffview.lib").views) == nil then
    vim.cmd('DiffviewOpen')
  else
    vim.cmd('DiffviewClose')
  end
end, { desc = "Toggle Diffview" })

-- Diffview for PR review (compare against origin/main or origin/master)
map('n', '<leader><leader>p', function()
  -- Try origin/main first, fall back to origin/master if it doesn't exist
  local main_branch = "origin/main"
  local check = vim.fn.system("git rev-parse --verify origin/main 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    main_branch = "origin/master"
  end
  vim.cmd('DiffviewOpen ' .. main_branch .. '... --imply-local')
end, { desc = "Diffview PR (compare with main/master)" })

-- Diffview file history for current branch changes
map('n', '<leader><leader>h', function()
  -- Try origin/main first, fall back to origin/master if it doesn't exist
  local main_branch = "origin/main"
  local check = vim.fn.system("git rev-parse --verify origin/main 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    main_branch = "origin/master"
  end
  vim.cmd('DiffviewFileHistory --range=' .. main_branch .. '...')
end, { desc = "Diffview file history (branch commits)" })

-- Diffview file history for current file
map('n', '<leader><leader>f', ':DiffviewFileHistory %<CR>', { desc = "Diffview file history (current file)" })

-- Session management
map("n", "<leader>so", ":OpenSession<Space>", opts)
map("n", "<leader>ss", ":SaveSession<Space>", opts)
map("n", "<leader>sd", ":DeleteSession<CR>", opts)
map("n", "<leader>sc", ":CloseSession<CR>", opts)

-- Working directory
map("n", "<leader>.", ":lcd %:p:h<CR>", opts)

-- Copy/Paste/Cut
map("n", "YY", '"+y<CR>', opts)
map("n", "<leader>p", '"+gP<CR>', opts)
map("n", "XX", '"+x<CR>', opts)

-- Buffer navigation
map("n", "<leader>z", ":bp<CR>", opts)
map("n", "<leader>q", ":bp<CR>", opts)
map("n", "<leader>x", ":bn<CR>", opts)
map("n", "<leader>w", ":bn<CR>", opts)
map("n", "<leader>c", ":b#<bar>bd#<CR>", opts)

-- Bufferline specific navigation
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
map("n", "<leader>bp", ":BufferLinePick<CR>", opts)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opts)
-- Quick buffer switching
for i = 1, 9 do
  map("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", opts)
end

-- Clear search highlight
map("n", "<leader><space>", ":noh<cr>", { silent = true })

-- Window switching
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-h>", "<C-w>h", opts)

-- Visual mode indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move visual blocks
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Open current line on GitHub
map("n", "<Leader>o", ":.Gbrowse<CR>", opts)

-- LSP mappings
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
map("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts)
map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

-- Trouble
map("n", "<leader>xx", function() require("trouble").toggle() end, opts)
map("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, opts)
map("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, opts)
map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, opts)
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end, opts)

-- Harpoon
local harpoon = require("harpoon")
map("n", "<leader>a", function() harpoon:list():add() end, opts)
map("n", "<C-S-P>", function() harpoon:list():prev() end, opts)
map("n", "<C-S-N>", function() harpoon:list():next() end, opts)

-- Bookmarks
local bm = require("bookmarks")
map("n", "mm", bm.bookmark_toggle, opts)
map("n", "mi", bm.bookmark_ann, opts)
map("n", "mc", bm.bookmark_clean, opts)
map("n", "mn", bm.bookmark_next, opts)
map("n", "mp", bm.bookmark_prev, opts)
map("n", "ml", bm.bookmark_list, opts)
map("n", "mx", bm.bookmark_clear_all, opts)

-- Minuet AI virtual text acceptance
vim.keymap.set('i', '<C-j>', function()
  local ok, minuet = pcall(require, 'minuet')
  if ok then
    -- Try to accept virtual text if available
    local accept_ok = pcall(function()
      minuet.accept_virtual_text()
    end)
    if accept_ok then
      return ''
    end
  end
  -- Fallback to default behavior (insert newline)
  return '<C-j>'
end, { expr = true, desc = "Accept Minuet suggestion or newline" })

-- Sidekick AI keybindings (disabled - using minuet instead)
-- See lua/config/sidekick_backup.lua for full configuration
--[[
vim.keymap.set({ "n", "i" }, "<Tab>", function()
  if not require("sidekick").nes_jump_or_apply() then
    -- Fallback to default Tab behavior if no suggestion
    return "<Tab>"
  end
end, { expr = true, desc = "Apply/Jump to next Sidekick suggestion" })

-- Copilot LSP commands
map("n", "<leader>ca", "<cmd>LspCopilotSignIn<CR>", { desc = "Sign in to Copilot" })
map("n", "<leader>cs", "<cmd>LspInfo<CR>", { desc = "Check LSP status (includes Copilot)" })

-- Sidekick-specific commands
map("n", "<leader>sh", "<cmd>checkhealth sidekick<CR>", { desc = "Check Sidekick health" })
map("n", "<leader>st", "<cmd>Sidekick nes toggle<CR>", { desc = "Toggle Next Edit Suggestions" })
map("n", "<leader>su", "<cmd>Sidekick nes update<CR>", { desc = "Update Next Edit Suggestions" })
map("n", "<leader>sc", "<cmd>Sidekick nes clear<CR>", { desc = "Clear Next Edit Suggestions" })

-- Check Copilot status
map("n", "<leader>si", function()
  local status = require("sidekick.status").get()
  if status then
    if status.busy then
      vim.notify("🔄 Copilot is thinking...", vim.log.levels.INFO)
    elseif status.kind == "Error" then
      vim.notify("❌ Copilot error: " .. (status.message or "Unknown"), vim.log.levels.ERROR)
    else
      vim.notify("✅ Copilot is ready", vim.log.levels.INFO)
    end
  else
    vim.notify("⚠️  Copilot not active", vim.log.levels.WARN)
  end
  
  -- Also show if there are any pending suggestions
  if require("sidekick.nes").have() then
    vim.notify("💡 Suggestions available - press Tab to apply", vim.log.levels.INFO)
  end
end, { desc = "Sidekick info - Check Copilot/Sidekick status" })
--]]

-- Kanagawa theme switcher
local function switch_kanagawa_theme()
  local themes = { "kanagawa-lotus", "kanagawa-wave", "kanagawa-dragon" }
  local current = vim.g.colors_name
  local current_idx = 1

  for i, theme in ipairs(themes) do
    if theme == current then
      current_idx = i
      break
    end
  end

  local next_idx = current_idx % #themes + 1
  vim.cmd("colorscheme " .. themes[next_idx])
  vim.notify("Switched to " .. themes[next_idx], vim.log.levels.INFO)
end

-- Theme switching keymaps
map("n", "<leader>kt", switch_kanagawa_theme, { desc = "Cycle Kanagawa themes" })
map("n", "<leader>kl", ":colorscheme kanagawa-lotus<CR>", { desc = "Kanagawa Lotus (light)" })
map("n", "<leader>kw", ":colorscheme kanagawa-wave<CR>", { desc = "Kanagawa Wave (dark)" })
map("n", "<leader>kd", ":colorscheme kanagawa-dragon<CR>", { desc = "Kanagawa Dragon (darker)" })



-- DAP (Debug Adapter Protocol) keymaps
-- Basic debugging
map("n", "<F5>", function() require("dap").continue() end, { desc = "DAP Continue/Start" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "DAP Step Over" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "DAP Step Into" })
map("n", "<leader>dn", function() require("dap").step_over() end, { desc = "DAP Step Over (Next)" })
map("n", "<leader>do", function() require("dap").step_out() end, { desc = "DAP Step Out" })
-- Alternative single-key bindings for stepping
map("n", "<M-n>", function() require("dap").step_over() end, { desc = "DAP Step Over" })
map("n", "<M-i>", function() require("dap").step_into() end, { desc = "DAP Step Into" })
map("n", "<M-o>", function() require("dap").step_out() end, { desc = "DAP Step Out" })
map("n", "<M-c>", function() require("dap").continue() end, { desc = "DAP Continue" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })
map("n", "<leader>dB", function() _G.dap_conditional_breakpoint() end, { desc = "DAP Conditional Breakpoint" })
map("n", "<leader>dl", function() _G.dap_log_breakpoint() end, { desc = "DAP Log Point" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "DAP REPL Open" })
map("n", "<leader>dR", function() require("dap").run_last() end, { desc = "DAP Run Last" })
map("n", "<leader>dc", function() _G.dap_run_to_cursor() end, { desc = "DAP Run to Cursor" })
map("n", "<leader>dt", function() require("dap").terminate() end, { desc = "DAP Terminate" })
map("n", "<leader>dx", function() require("dap").clear_breakpoints() end, { desc = "DAP Clear All Breakpoints" })

-- DAP UI
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "DAP UI Toggle" })
map("n", "<leader>de", function() require("dapui").eval() end, { desc = "DAP Eval Expression" })
map("v", "<leader>de", function() require("dapui").eval() end, { desc = "DAP Eval Expression" })
map("n", "<leader>df", function() require("dapui").float_element() end, { desc = "DAP UI Float Element" })
map("n", "<leader>ds", function() 
  require("dapui").float_element("scopes", { enter = true })
end, { desc = "DAP Show Scopes (variables)" })
map("n", "<leader>dh", function() 
  require("dap.ui.widgets").hover()
end, { desc = "DAP Hover (show variable value)" })
map("n", "<leader>dw", function()
  local widgets = require("dap.ui.widgets")
  local word = vim.fn.expand("<cexpr>")
  widgets.sidebar(widgets.expression, nil, word).open()
end, { desc = "DAP Watch expression" })
map("n", "<leader>da", function()
  local expr = vim.fn.input("Watch expression: ")
  if expr ~= "" then
    require("dapui").elements.watches.add(expr)
  end
end, { desc = "DAP Add watch expression" })
-- Helper to list available variables
map("n", "<leader>dv", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "DAP Show all variables in scope" })

-- Telescope DAP integration
map("n", "<leader>dcc", "<cmd>Telescope dap commands<cr>", { desc = "DAP Commands" })
map("n", "<leader>dco", "<cmd>Telescope dap configurations<cr>", { desc = "DAP Configurations" })
map("n", "<leader>dlb", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "DAP List Breakpoints" })
map("n", "<leader>dv", "<cmd>Telescope dap variables<cr>", { desc = "DAP Variables" })
map("n", "<leader>dff", "<cmd>Telescope dap frames<cr>", { desc = "DAP Frames" })

-- Language specific debugging
-- Python
map("n", "<leader>dpm", function() require("dap-python").test_method() end, { desc = "DAP Python Test Method" })
map("n", "<leader>dpc", function() require("dap-python").test_class() end, { desc = "DAP Python Test Class" })
map("v", "<leader>ds", function() require("dap-python").debug_selection() end, { desc = "DAP Python Debug Selection" })

-- Go
map("n", "<leader>dgt", function() require("dap-go").debug_test() end, { desc = "DAP Go Debug Test" })
map("n", "<leader>dgl", function() require("dap-go").debug_last_test() end, { desc = "DAP Go Debug Last Test" })

-- Lua (for Neovim config debugging)
map("n", "<leader>dln", function()
  require("osv").launch({port = 8086})
  vim.notify("Lua debugger server started on port 8086", vim.log.levels.INFO)
end, { desc = "Start Lua Debug Server" })

map("n", "<leader>dlr", function()
  require("osv").run_this()
end, { desc = "Run Current Lua File in Debug Mode" })

-- macOS specific
if vim.fn.has("macunix") == 1 then
  map("v", "<C-x>", ":!pbcopy<CR>", opts)
  map("v", "<C-c>", ":w !pbcopy<CR><CR>", opts)
end