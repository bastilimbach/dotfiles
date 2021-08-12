" Keymaps
nnoremap <SPACE> <Nop>
let mapleader = " "

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<cr>
if exists('g:vscode')
  nnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
  nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeWindow')<CR>
endif
nnoremap H ^
nnoremap L $
inoremap jk <ESC>
inoremap kj <ESC>
nnoremap <ESC> :set hlsearch!<CR>
nnoremap J 6j
nnoremap K 6k
vnoremap K 6k
vnoremap J 6j

" Stay in normal mode after inserting a new line
noremap o o <Esc>
noremap O O <Esc>

" General settings
syntax on
filetype plugin indent on
set number
set relativenumber
set clipboard^=unnamed,unnamedplus
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

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Install vim-plug if not found
let data_dir = stdpath('data') . '/site/autoload'
if empty(glob(data_dir . '/plug.vim'))
  silent !curl -fLo '.data_dir.'/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim',
  Plug 'unblevable/quick-scope'
  Plug 'rstacruz/vim-closer', Cond(!exists('g:vscode'))
  Plug 'machakann/vim-highlightedyank'
  Plug 'andymass/vim-matchup', Cond(!exists('g:vscode'))
  Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode'))
  Plug 'junegunn/vim-peekaboo', Cond(!exists('g:vscode'))
  Plug 'suy/vim-context-commentstring'

  " Themes
  Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Plugins config
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
