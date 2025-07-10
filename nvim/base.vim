" --------------
" Base config (shared by all environments)
" --------------

nnoremap <SPACE> <Nop>
let mapleader = " "
inoremap jk <ESC>
tnoremap <ESC> <C-\><C-n>
nnoremap <leader>ve <cmd>tabedit $MYVIMRC<CR>
nnoremap <leader>vr <cmd>source $MYVIMRC<CR>

" Copy & Paste
map <leader>y "*y
map <leader>yy "*yy
map <leader>Y "*Y
map <leader>p "*p<CR>
map <leader>P "*P<CR>
nnoremap Y y$
" Maintain the cursor position when yanking a visual selection
vnoremap <expr>y "my\"" . v:register . "y`y"
vnoremap <expr>Y "my\"" . v:register . "Y`y"
vnoremap p "_dP

" Save & Quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa<CR>

" Navigate between windows
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

" Line ending/start on home row
nnoremap H ^
nnoremap L $

" Settings toggles
nnoremap <ESC> :set hlsearch!<CR>

" Faster scrolling
nnoremap J 6j
nnoremap K 6k
vnoremap K 6k
vnoremap J 6j

" Stay in normal mode after inserting a new line
noremap o o <Esc>
noremap O O <Esc>

" Un-/indent using TAB
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >
vnoremap <S-TAB> <

" LSP keymaps (to be extended in env-specific configs)

" --------------
" General settings
" --------------
syntax on
filetype plugin indent on
set number
set relativenumber
set undolevels=1000
set noshowmode
set completeopt=menu,menuone,noselect
set mouse=a

" Backup
set noswapfile
set nobackup
set nowritebackup

" Search
set hlsearch
set ignorecase
set incsearch
set smartcase

" Indentation
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab
set autoindent
set foldmethod=indent
set foldlevel=99
set foldlevelstart=99
set listchars=space:·,tab:>-,eol:↴,precedes:«,extends:»,trail:~
set list
set fillchars+=diff:╱

" Splits
set splitbelow
set splitright

" --------------
" Utility functions
" --------------
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

func! WinMove(key)
  let t:curwin = winnr()
  exec 'wincmd '.a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec 'wincmd '.a:key
  endif
endfu

" --------------
" Plugins (shared and environment-specific)
" --------------

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
  " Plugins for all environments
  Plug 'tpope/vim-surround'           " Provides mappings to easily change surroundings in pairs.
  Plug 'wellle/targets.vim'           " Adds various text objects to give you more targets to operate on.
  Plug 'tpope/vim-repeat'             " Makes plugin actions repeatable using dot.
  Plug 'tpope/vim-sleuth'             " Automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file.
  Plug 'unblevable/quick-scope'       " Highlight unique character in every word to help with f, F.
  Plug 'justinmk/vim-sneak'           " Jump vertically using two characters.

  " Environment-specific plugins
  if !exists('g:vscode') && !has('ide')
    Plug 'm4xshen/hardtime.nvim'                " Break bad habits, master Vim motions.
    Plug 'nvim-lua/plenary.nvim'                " Dependency for a lot of lua plugins. Packages many lua utility functions.
    Plug 'nvim-telescope/telescope.nvim'        " Fuzzy file finder.
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " Makes fuzzy finding in telescope faster.
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlighting and other stuff.
    Plug 'neovim/nvim-lspconfig'                " Used to configure neovim lsp for different lsp servers.
    Plug 'nvim-lualine/lualine.nvim'            " Statusbar
    Plug 'junegunn/vim-peekaboo'                " Displays a right buffer to view register content & select the desired register before pasting.
    Plug 'windwp/nvim-autopairs'                " Automatically inserts matching brackets & quotes.
    Plug 'kyazdani42/nvim-tree.lua'             " Sidebar which displays the current working-tree (files).
    Plug 'kyazdani42/nvim-web-devicons'         " Icons for nvim-tree.
    Plug 'hrsh7th/nvim-cmp'                     " Autocompletion plugin.
    Plug 'hrsh7th/vim-vsnip'                    " Snipped engine used by nvim-cmp. Used to insert code snippets.
    Plug 'hrsh7th/cmp-nvim-lsp'                 " LSP source for nvim-cmp. Is required to display lsp content in the autocomplete popover.
    Plug 'hrsh7th/cmp-vsnip'                    " VSnip source for nvim-cmp.
    Plug 'hrsh7th/cmp-buffer'                   " Buffer source for nvim-cmp.
    Plug 'ray-x/lsp_signature.nvim'             " Shows function signature when you type.
    Plug 'onsails/lspkind-nvim'                 " Adds pictograms to completion popups.
    Plug 'lukas-reineke/indent-blankline.nvim'  " Display indentation lines.
    Plug 'folke/trouble.nvim'                   " Display diagnostics in a pretty list.
    Plug 'voldikss/vim-floaterm'                " Use the terminal in a floating/popup window.
    Plug 'sindrets/diffview.nvim'               " Single tabpage interface for easily cycling through git diffs.
    Plug 'rmagatti/auto-session'                " Automatically creates sessions on exit & restores them as soon as vim is started.
    Plug 'numToStr/Comment.nvim'                " Smart and Powerful commenting plugin for neovim
    Plug 'catppuccin/nvim'                      " Theme
  endif
call plug#end()
