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
