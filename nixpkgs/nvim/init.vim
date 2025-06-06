set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" source ~/Projects/nix-configs/nixpkgs/nvim/config.vim
" vim-bootstrap b990cad

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'chrisbra/Colorizer'
Plug 'hwayne/tla.vim'
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'
Plug 'edluffy/hologram.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'shortcuts/no-neck-pain.nvim'
Plug 'mg979/vim-visual-multi'
Plug 'rebelot/kanagawa.nvim'
Plug 'AlessandroYorba/alduin'
Plug 'AlessandroYorba/sierra'
Plug 'sainnhe/everforest'
Plug 'tomasky/bookmarks.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'ryanoasis/vim-devicons'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'ruanyl/vim-gh-line'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'ggandor/leap.nvim'
Plug 'vim-scripts/CSApprox'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'avelino/vim-bootstrap-updater'
Plug 'sheerun/vim-polyglot'
" Plug 'mrcjkb/rustaceanvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 't-troebst/perfanno.nvim'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'p00f/godbolt.nvim'
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }

" colorscheme
Plug 'tjdevries/colorbuddy.nvim'
Plug 'jesseleite/nvim-noirbuddy'
" Plug 'projekt0n/github-nvim-theme'

" For russian comments
Plug 'kraftwerk28/gtranslate.nvim'

" AI
" Plug 'supermaven-inc/supermaven-nvim'
Plug 'onsails/lspkind.nvim'
Plug 'github/copilot.vim'

Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

" lean
" Plug 'Julian/lean.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'

" Snippets
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
" Plug 'saadparwaiz1/cmp_luasnip'
Plug 'molleweide/LuaSnip-snippets.nvim'
Plug 'rafamadriz/friendly-snippets'

" Plug 'honza/vim-snippets'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-buffer'
Plug 'sindrets/diffview.nvim'
Plug 'pwntester/octo.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Vim-Session
if v:version >= 703
  Plug 'Shougo/vimshell.vim'
endif

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" Enable highlighting and whitespace on save by default
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" zathura can do all this??
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_view_automatic = 1
let conceallevel = 1
let g:tex_conceal = 'abdmg'
function! ViewerCallback() dict
    call self.forward_search(self.out())
endfunction
let g:vimtex_view_zathura_hook_callback = 'ViewerCallback'

"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
" set encoding=utf-8
" set fileencoding=utf-8
" set fileencodings=utf-8
set bomb
set binary
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number relativenumber
set nu rnu

" set light mode
set background=dark

let no_buffers_menu=1
" see lua config
" if !exists('g:not_finish_vimplug')
"   colorscheme alduin
" endif

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine - the magic line when you indent something
  let g:indentLine_enabled = 1
  " let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1

endif

"" this is so rust has color
if &term == "alacritty"
  let &term = "xterm-256color"
endif
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"

if &term =~ '256color'
  set t_ut=
endif


"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have these shortcuts
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

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 35
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

"*****************************************************************************
"" Functions
"*****************************************************************************

"" Set up automatic word wrapping
"" Defaults: 80 textwidth and 81 colorcolumn
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set tw=80
    " not friends with colorcolumn any more
    set colorcolumn=0
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************

imap <silent><script><expr> <C-j> copilot#Accept("")
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************

"" The PC is fast enough, do syntax highlight syncing from start unless 500 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Just always word wrap
call s:setupWrapping()

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

"" Set up column width for certain file types
augroup filetypedetect
  "" Programming Languages
  autocmd Filetype cpp setlocal tw=80
  autocmd Filetype c setlocal tw=80
  autocmd Filetype go setlocal tw=80

  "" Text
  autocmd Filetype tex setlocal spell tw=80
  autocmd Filetype text setlocal spell tw=72
  autocmd Filetype markdown setlocal spell tw=0
  
  "" EVM Assembly
  autocmd BufRead,BufNewFile *.eas,*.evm,*.evmasm setfiletype evmasm
  autocmd FileType evmasm setlocal commentstring=;\ %s
augroup end

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Telescope commands
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope bookmarks list<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fe <cmd>Telescope diagnostics<cr>

" Using Lua functions
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"" Vimtex commands
noremap <Leader>tc :VimtexTocToggle<CR>
noremap <Leader>tv :VimtexTocOpen<CR>
noremap <Leader>lc :VimtexView<CR>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Git write<CR>
noremap <Leader>gc :Git commit<CR>
noremap <Leader>gsh :Git push<CR>
noremap <Leader>gll :Git pull<CR>
noremap <Leader>gs :Git status<CR>
noremap <Leader>gb :Git blame<CR>
" noremap <Leader>gd :Git diff<CR>
noremap <Leader>gr :Git remove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
" nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

let g:gh_trace = 1
"" fzf.vim

" Tagbar
" noremap <silent> <leader>tt :TagbarToggle<CR>
" let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>

endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
" noremap <leader>c :bd<CR>

"" Close buffer, without closing the window
noremap <leader>c :b#<bar>bd#<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" LSP configs
"*****************************************************************************

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" set swap time to pretty short so we have a shorter hover time -- also changes
" swap
" https://www.reddit.com/r/neovim/comments/mn7coe/lsp_autoshow_diagnostics_on_hover_in_popup_window/
set updatetime=2000

lua <<EOF
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

require("trouble").setup {}
-- Lua
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)

require('avante_lib').load()
local avante_opts = {
  provider = "gemini",
  gemini = {
    endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
    model = "gemini-2.5-pro-preview-03-25",
    timeout = 30000,
    temperature = 0,
    max_tokens = 1048576,
  },
}

require('avante').setup(avante_opts)

-- colorscheme setup
-- require("noirbuddy").setup()
vim.cmd('colorscheme kanagawa')

-- Or with configuration
-- require('github-theme').setup({
--   -- ...
-- })

-- vim.cmd('colorscheme github_dark')

-- -- Example config in Lua
-- require("github-theme").setup({
--   theme_style = "dark",
--   function_style = "italic",
--   sidebars = {"qf", "vista_kind", "terminal", "packer"},
--
--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   colors = {hint = "orange", error = "#ff0000"},
--
--   -- Overwrite the highlight groups
--   overrides = function(c)
--     return {
--       htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
--       DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
--       -- this will remove the highlight groups
--       TSField = {},
--     }
--   end
-- })

vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})

-- use telescope for references, implementations, definitions, type definitions
vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gy', '<cmd>Telescope lsp_type_definitions<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', {noremap = true})

-- from/for telescope-file-browser
-- if I wanted to configure telescope-file-browser it would go here
require("telescope").load_extension "file_browser"
vim.api.nvim_set_keymap(
  "n",
  "<leader>fv",
  ":Telescope file_browser<CR>",
  { noremap = true }
)

local example_setup = {
  on_attach = function(client, bufnr)
    require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
  end,
}

require "lsp_signature".setup(example_setup)

-- require("supermaven-nvim").setup({
--   keymaps = {
--     accept_suggestion = "<C-l>",
--     clear_suggestion = "<C-]>",
--     accept_word = "<C-j>",
--   },
--   disable_inline_completion = true, -- disables inline completion for use with cmp
--   disable_keymaps = false -- disables built in keymaps for more manual control
-- })

require("octo").setup()

-- Copied from rust-tools
local lspconfig_utils = require("lspconfig.util")
local function get_root_dir(filename)
    local fname = filename or vim.api.nvim_buf_get_name(0)
    local cargo_crate_dir = lspconfig_utils.root_pattern("Cargo.toml")(fname)
    local cmd = { "cargo", "metadata", "--no-deps", "--format-version", "1" }
    if cargo_crate_dir ~= nil then
		cmd[#cmd + 1] = "--manifest-path"
		cmd[#cmd + 1] = lspconfig_utils.path.join(cargo_crate_dir, "Cargo.toml")
	end
	local cargo_metadata = ""
	local cm = vim.fn.jobstart(cmd, {
		on_stdout = function(_, d, _)
			cargo_metadata = table.concat(d, "\n")
		end,
		stdout_buffered = true,
	})
	if cm > 0 then
		cm = vim.fn.jobwait({ cm })[1]
	else
		cm = -1
	end
	local cargo_workspace_dir = nil
	if cm == 0 then
		cargo_workspace_dir = vim.fn.json_decode(cargo_metadata)["workspace_root"]
	end
	return cargo_workspace_dir
		or cargo_crate_dir
		or lspconfig_utils.root_pattern("rust-project.json")(fname)
		or lspconfig_utils.find_git_ancestor(fname)
end

-- hopefully this doesn't return a trailing slash
-- local temp_ra_target_dir = get_root_dir()
-- -- find the directory name / end of path
-- if temp_ra_target_dir ~= nil then
--     while(string.find(temp_ra_target_dir, "/") ~= nil)
--     do
--         idx = string.find(temp_ra_target_dir, "/")
--         temp_ra_target_dir = string.sub(temp_ra_target_dir, idx+1)
--     end
--     -- given /home/whoever/project this should return project
--
--     if temp_ra_target_dir == nil then
--         temp_ra_target_dir = "rust-analyzer-check"
--     end
--     temp_ra_target_dir = "/tmp/" .. temp_ra_target_dir
-- end

-- bookmarks
require('bookmarks').setup {
  -- sign_priority = 8,  --set bookmark sign priority to cover other sign
  save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
  keywords =  {
    ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
    ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
    ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
  },
  on_attach = function(bufnr)
    local bm = require "bookmarks"
    local map = vim.keymap.set
    map("n","mm",bm.bookmark_toggle) -- add or remove bookmark at current line
    map("n","mi",bm.bookmark_ann) -- add or edit mark annotation at current line
    map("n","mc",bm.bookmark_clean) -- clean all marks in local buffer
    map("n","mn",bm.bookmark_next) -- jump to next mark in local buffer
    map("n","mp",bm.bookmark_prev) -- jump to previous mark in local buffer
    map("n","ml",bm.bookmark_list) -- show marked file list in quickfix window
    map("n","mx",bm.bookmark_clear_all) -- removes all bookmarks
  end
}

local nvim_lsp = require'lspconfig'

local cargo_features = nil

-- gets rid of server cancelled the request logs
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

local opts = {
    cmd = { "/home/dan/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer" },
    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    server = {
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
                extraEnv = {
                    ["RA_LOG"] = "debug",
                    ["RUSTUP_TOOLCHAIN"] = "nightly",
                },
                check = {
                    command = "clippy",
                },
            },
        },
        ra_multiplex = { enable = false, },
        capabilities = {
            workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true
                }
            }
        }
    },

    tools = { -- rust-tools options
        procMacro = true,
        autoSetHints = true,
        runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true
            -- rest of the opts are forwarded to telescope
        },
        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true
            -- rest of the opts are forwarded to telescope
        },
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,

            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "Comment",
        },
    },

    -- debugging stuff
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
        },
    },
}

-- print("--target-dir " .. temp_ra_target_dir)

local border = {
    {"╭", "FloatBorder"}, {"─", "FloatBorder"},
    {"╮", "FloatBorder"}, {"│", "FloatBorder"},
    {"╯", "FloatBorder"}, {"─", "FloatBorder"},
    {"╰", "FloatBorder"}, {"│", "FloatBorder"}
}

-- fun borders for documentation and signature help
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

nvim_lsp.ccls.setup{
  lsp = {
    format_on_save = false,
  },
  handlers = handlers
}
nvim_lsp.gopls.setup{handlers = handlers}

-- puts diagnostics in a hover window!!
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

require('leap').add_default_mappings()
require('perfanno').setup()

-- vim.g.rustaceanvim = opts

require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
        cmd = { "/home/dan/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer" },
        extraEnv = {
            ["RA_LOG"] = "debug",
        },
    }
  }
}

-- EVM Assembly LSP Configuration
-- Register the custom LSP server
local configs = require('lspconfig.configs')
if not configs.evm_asm_lsp then
  configs.evm_asm_lsp = {
    default_config = {
      cmd = { 'evm-asm-lsp' },
      filetypes = { 'evmasm', 'eas', 'evm' },
      root_dir = nvim_lsp.util.root_pattern('.git', 'Makefile', 'package.json'),
      settings = {},
    },
  }
end

-- Setup EVM Assembly LSP with handlers
nvim_lsp.evm_asm_lsp.setup{
  handlers = handlers,
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    
    -- Use the same on_attach as other servers
    require "lsp_signature".on_attach({
      bind = true,
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
  end,
}

-- Language snippet completion
-- See https://github.com/molleweide/LuaSnip-snippets.nvim
local luasnip = require("luasnip")

-- be sure to load this first since it overwrites the snippets table.
-- luasnip.snippets = require("luasnip_snippets").load_snippets()

-- friendly-snippets
-- require("luasnip.loaders.from_vscode").lazy_load()
require("no-neck-pain").setup({
    width = 200,
})

-- completion type
local lspkind = require('lspkind')

 -- Setup Completion
 -- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({

  -- Enable LSP snippets
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- formatting to show supermaven suggestion
  -- formatting = {
  --   format = lspkind.cmp_format({
  --     mode = "symbol",
  --     max_width = 50,
  --     symbol_map = { Supermaven = "" }
  --   })
  -- },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    -- { name = 'supermaven' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_install = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,
}

-- EVM Assembly Tree-sitter Configuration
-- Register the parser
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.evm_asm = {
  install_info = {
    url = "~/projects/evm-asm-lsp/crates/tree-sitter-evm-asm",
    files = {"src/parser.c"},
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "evmasm",
}

-- Add filetype detection for EVM Assembly in Lua too
vim.filetype.add({
  extension = {
    eas = 'evmasm',
    evm = 'evmasm',
    evmasm = 'evmasm',
  }
})

-- Auto-enable Tree-sitter highlighting for EVM Assembly
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'evmasm',
  callback = function()
    -- Enable Tree-sitter highlighting for this buffer
    vim.defer_fn(function()
      pcall(vim.cmd, 'TSBufEnable highlight')
    end, 100)
  end,
})

-- for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
--     local default_diagnostic_handler = vim.lsp.handlers[method]
--     vim.lsp.handlers[method] = function(err, result, context, config)
--         if err ~= nil and err.code == -32802 then
--             return
--         end
--         return default_diagnostic_handler(err, result, context, config)
--     end
-- end

require("godbolt").setup({
    languages = {
        cpp = { compiler = "g122", options = {} },
        c = { compiler = "cg122", options = {} },
        rust = { compiler = "r1650", options = {} },
        -- any_additional_filetype = { compiler = ..., options = ... },
    },
    quickfix = {
        enable = false, -- whether to populate the quickfix list in case of errors
        auto_open = false -- whether to open the quickfix list in case of errors
    },
    url = "https://godbolt.org" -- can be changed to a different godbolt instance
})

-- harpoon setup
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

require("telescope").load_extension('bookmarks')

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

EOF

"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" set airline dark theme
let g:airline_theme='google_dark'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '' " used to be ▶
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '' " used to be ◀
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⎇' "➔, ➥, ⎇, used to be ⤴
  let g:airline#extensions#readonly#symbol   = '' " used to be ⊘
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␤' " used to be ␊
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

