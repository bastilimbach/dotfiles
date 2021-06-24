" https://gist.github.com/synasius/5cdc75c1c8171732c817
inoremap jk <ESC>
inoremap kj <ESC>
nnoremap <ESC> :set hlsearch!<CR>
let mapleader = "'"
syntax on
set number
set noswapfile
set hlsearch
set ignorecase
set incsearch
set relativenumber
set nu
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent
set clipboard^=unnamed,unnamedplus

call plug#begin(stdpath('data') . '/plugged')
" Plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'
" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
