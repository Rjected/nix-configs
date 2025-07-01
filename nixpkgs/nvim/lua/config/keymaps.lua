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

-- NERDTree
map("n", "<F2>", ":NERDTreeFind<CR>", { silent = true })
map("n", "<F3>", ":NERDTreeToggle<CR>", { silent = true })

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

-- Copilot
map("i", "<C-j>", 'copilot#Accept("")', { silent = true, script = true, expr = true })

-- macOS specific
if vim.fn.has("macunix") == 1 then
  map("v", "<C-x>", ":!pbcopy<CR>", opts)
  map("v", "<C-c>", ":w !pbcopy<CR><CR>", opts)
end