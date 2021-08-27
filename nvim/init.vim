" --------------
" Keymaps
" --------------
nnoremap <SPACE> <Nop>
let mapleader = " "
inoremap jk <ESC>
inoremap kj <ESC>

" Copy & Paste
map <leader>y "*y
map <leader>yy "*yy
map <leader>Y "*Y
map <leader>p "*p<CR>
map <leader>P "*P<CR>
nnoremap Y y$

" Save & Quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
if exists('g:vscode')
  nnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
  nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeWindow')<CR>
endif

" Navigate between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
if exists('g:vscode')
  nnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  nnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
  nnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  nnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
endif

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

" Plugin keymaps
" nnoremap <leader>v <cmd>CHADopen<CR>
 
" Telescope keymaps 
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
 
" --------------
" General settings
" --------------
syntax on
filetype plugin indent on
set number
set relativenumber
set undolevels=1000
set noshowmode

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
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent

" --------------
" Plugins
" --------------
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | q
\| endif

call plug#begin(stdpath('data') . '/plugged')
  " Plugins
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'unblevable/quick-scope'
  Plug 'machakann/vim-highlightedyank'
  Plug 'suy/vim-context-commentstring'
  Plug 'justinmk/vim-sneak'

  " Disable certain plugins for VSCode
  if !exists('g:vscode')
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim' 
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } 
    Plug 'neovim/nvim-lspconfig'
    Plug 'andymass/vim-matchup'
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/vim-peekaboo'
    Plug 'rstacruz/vim-closer'
    " Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    " Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  endif

  " Themes
  Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Plugins config
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:sneak#label = 1

" --------------
" Colorscheme & Highlights
" --------------
colorscheme dracula
highlight Normal guibg=NONE ctermbg=NONE
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
highlight Sneak guibg=NONE guifg='#afff5f' gui=underline ctermfg=81 cterm=underline
highlight SneakLabel guibg=NONE guifg='#afff5f' gui=underline ctermfg=81 cterm=underline
 
if !exists('g:vscode')
  
" --------------
" Telescope
" --------------
lua <<EOF
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
    }
  }
}
require('telescope').load_extension('fzf') 
EOF
 
" --------------
" Treesitter
" --------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
EOF
 
 
" --------------
" LSP
" --------------
lua << EOF
  local lsp = require "lspconfig"
  -- local coq = require "coq"
  -- lsp.tsserver.setup(coq.lsp_ensure_capabilities())
  -- lsp.tsserver.setup()
EOF
   
endif
