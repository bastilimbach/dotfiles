" --------------
" Main init.vim
" --------------

" Source base config
source $DOTFILES/nvim/base.vim

" Source environment-specific config
if exists('g:vscode')
  source $DOTFILES/nvim/vscode.vim
elseif has('ide')
  source $DOTFILES/nvim/idea.vim
else
  source $DOTFILES/nvim/neovim.vim
endif
