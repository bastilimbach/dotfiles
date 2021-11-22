" --------------
" Keymaps
" --------------
nnoremap <SPACE> <Nop>
let mapleader = " "
inoremap jk <ESC>
inoremap kj <ESC>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

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

" Save & Quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa<CR>
if exists('g:vscode')
  nnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
  nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeWindow')<CR>
endif

" Navigate between windows
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>
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
nnoremap <leader>v <cmd>NvimTreeToggle<CR>
nnoremap <leader>xx <cmd>TroubleToggle<CR>

" Telescope keymaps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fd <cmd>Telescope lsp_document_diagnostics<cr>

" Floaterm keymaps
nnoremap <silent> <leader>t :FloatermToggle<CR>
nnoremap <silent> <leader>n :FloatermPrev<CR>
nnoremap <silent> <leader>m :FloatermNext<CR>
nnoremap <silent> <leader>k :FloatermKill<CR>

" LSP keymaps
nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>x <cmd>lua vim.diagnostic.show_line_diagnostics({ show_header = false })<CR>

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
set foldmethod=indent
set listchars=space:·,tab:>-,eol:↴,precedes:«,extends:»,trail:~
set list
set fillchars+=diff:╱

" Splits
set splitbelow
set splitright

" --------------
" Autocommands
" --------------
augroup TrimTrailingWhiteSpace
  au!
  au BufWritePre * %s/\s\+$//e
  au BufWritePre * %s/\n\+\%$//e
augroup END

" --------------
" Utility functions
" --------------
" Function to conditionally enable/disable plugins. E.g: Plug 'XYZ', Cond(...),
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Either creates a new window or moves the cursor to an existing one
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
" Plugins
" --------------
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
  Plug 'tpope/vim-surround' " Provides mappings to easily change surroundings in pairs.
  Plug 'tpope/vim-repeat' " Makes plugin actions repeatable using dot.
  Plug 'tpope/vim-commentary' " Commenting.
  Plug 'unblevable/quick-scope' " Highlight unique character in every word to help with f, F.
  Plug 'machakann/vim-highlightedyank' " Highlight yanked lines.
  Plug 'JoosepAlviste/nvim-ts-context-commentstring' " Makes it possible to use vim-commentary with files which include different types. E.g: javascript in html
  Plug 'justinmk/vim-sneak' " Jump vertically using two characters.

  " Disable certain plugins for VSCode
  if !exists('g:vscode')
    Plug 'nvim-lua/plenary.nvim' " Dependency for a lot of lua plugins. Packages many lua utility functions.
    Plug 'nvim-telescope/telescope.nvim' " Fuzzy file finder.
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " Makes fuzzy finding in telescope faster.
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlighting and other stuff.
    Plug 'neovim/nvim-lspconfig' " Used to configure neovim lsp for different lsp servers.
    Plug 'nvim-lualine/lualine.nvim' " Statusbar
    Plug 'junegunn/vim-peekaboo' " Displays a right buffer to view register content & select the desired register before pasting.
    Plug 'jiangmiao/auto-pairs' " Automatically inserts matching brackets & quotes.
    Plug 'kyazdani42/nvim-tree.lua' " Sidebar which displays the current working-tree (files).
    Plug 'kyazdani42/nvim-web-devicons' " Icons for nvim-tree.
    Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin.
    Plug 'hrsh7th/vim-vsnip' " Snipped engine used by nvim-cmp. Used to insert code snippets.
    Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp. Is required to display lsp content in the autocomplete popover.
    Plug 'hrsh7th/cmp-vsnip' " VSnip source for nvim-cmp.
    Plug 'hrsh7th/cmp-buffer' " Buffer source for nvim-cmp.
    Plug 'ray-x/lsp_signature.nvim' " Shows function signature when you type.
    Plug 'onsails/lspkind-nvim' " Adds pictograms to completion popups.
    Plug 'lukas-reineke/indent-blankline.nvim' " Display indentation lines.
    Plug 'folke/trouble.nvim' " Display diagnostics in a pretty list.
    Plug 'voldikss/vim-floaterm' " Use the terminal in a floating/popup window.
    Plug 'sindrets/diffview.nvim' " Single tabpage interface for easily cycling through git diffs.
    Plug 'rmagatti/auto-session' " Automatically creates sessions on exit & restores them as soon as vim is started.

    " Themes
    Plug 'Pocco81/Catppuccino.nvim'
  endif
call plug#end()

" --------------
" Colorscheme & Highlights
" --------------
if !exists('g:vscode')
lua <<EOF
  -- Require theme and set configuration
  require('catppuccino').setup {
    colorscheme = 'neon_latte',
    term_colors = true,
    integrations = {
      telescope = true
    },
    nvimtree = {
      enabled = true
    }
  }
EOF
  colorscheme catppuccino
endif

set background=dark
set termguicolors

" Custom highlights
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
highlight Sneak guifg='#afff5f' gui=underline ctermfg=81 cterm=underline
highlight SneakLabel guifg='#afff5f' gui=underline ctermfg=81 cterm=underline
highlight SneakLabelMask guifg=NONE ctermfg=NONE cterm=nocombine
highlight DiffAdd guibg='#164846'
highlight DiffDelete guibg='#823c41'
highlight DiffChange guibg='#394b70'

" --------------
" Plugin config
" --------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:sneak#label = 1
let g:sneak#prompt = '👞'
let g:floaterm_title = '($1|$2)'

if !exists('g:vscode')
lua <<EOF
  -- Nvim Tree
  require('nvim-tree').setup {
    diagnostics = {
      enable = true
    },
    update_focused_file = {
      enable = true,
    },
    view = {
      auto_resize = true
    }
  }

  -- Lualine
  require('lualine').setup {
    options = {
      theme = 'iceberg_dark',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          cond = function() return vim.fn.winwidth(0) > 80 end
        },
        {
          'diff',
          cond = function() return vim.fn.winwidth(0) > 80 end
        },
        {
          'diagnostics',
          sources = { 'nvim_lsp' },
          cond = function() return vim.fn.winwidth(0) > 50 end
        },
      },
      lualine_c = { 'filename' },
      lualine_x = {
        {
          'encoding',
          cond = function() return vim.fn.winwidth(0) > 100 end
        }
      },
      lualine_y = {
        {
          'progress',
          cond = function() return vim.fn.winwidth(0) > 100 end
        }
      },
      lualine_z = {
        {
          'location',
          cond = function() return vim.fn.winwidth(0) > 100 end
        }
      },
    },
    extensions = { 'nvim-tree' },
  }

  -- Telescope
  local telescope = require('telescope')
  telescope.setup {
    defaults = {
      file_ignore_patterns = { '.git' },
      path_display = { 'truncate' },
      mappings = {
        i = {
          ['<ESC>'] = require('telescope.actions').close,
        },
        n = {
          ['q'] = require('telescope.actions').close,
        }
      }
    },
    pickers = {
      find_files = {
        hidden = true
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    }
  }
  telescope.load_extension('fzf')

  -- Treesitter
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'html',
      'javascript',
      'typescript',
      'json',
      'json5',
      'jsonc',
      'regex',
      'rust',
      'vim',
      'vue',
      'yaml',
      'css',
      'bash'
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
    }
  }

  -- Set foldmethod to 'expr' and use treesitter if the parser for the current filetype is installed.
  local parsers = require('nvim-treesitter.parsers')
  local configs = parsers.get_parser_configs()
  local ft_str = table.concat(
    vim.tbl_map(function(ft) return configs[ft].filetype or ft end, parsers.available_parsers()
  ), ',')
  vim.cmd('autocmd Filetype ' .. ft_str .. ' setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()')
  -- LSP
  -- Completion
  local cmp = require('cmp')
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer', keyword_length = 5 }
    },
    mapping = {
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    },
    formatting = {
      format = require("lspkind").cmp_format({
        with_text = true,
        menu = ({
          nvim_lsp = "[LSP]",
          vsnip = "[Snippet]",
          buffer = "[Buffer]",
        })
      }),
    }
  }
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- LSP config
  local on_lsp_attach = function (client)
    -- If the lsp server support formatting format the buffer on save.
    if client.resolved_capabilities.document_formatting then
      vim.cmd [[augroup Format]]
      vim.cmd [[autocmd! * <buffer>]]
      vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
      vim.cmd [[augroup END]]
    end

    require('lsp_signature').on_attach({
      bind = true,
      handler_opts = {
        border = 'none'
      },
      hint_enable = false,
      padding = ' '
    })
  end

  local lsp = require('lspconfig')
  lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = function (client)
      -- Disable document formatting for tsserver as efm will do this
      client.resolved_capabilities.document_formatting = false
      on_lsp_attach(client)
    end
  }

  lsp.vuels.setup {}

  local eslint_d = {
    lintCommand = 'eslint_d --cache -f visualstudio --stdin --stdin-filename ${INPUT}',
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {
      '%f(%l,%c): %tarning %m',
      '%f(%l,%c): %trror %m'
    },
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}',
    formatStdin = true
  }

  lsp.efm.setup {
    on_attach = on_lsp_attach,
    filetypes = { 'javascript', 'typescript', 'vue' },
    init_options = {
      documentFormatting = true
    },
    settings = {
      rootMarkers = { '.git' },
      lintDebounce = 500,
      languages = {
        typescript = { eslint_d },
        javascript = { eslint_d },
        vue = { eslint_d }
      }
    }
  }

  -- LSP handlers
  vim.lsp.handlers['textDocument/formatting'] = function(err, result, ctx)
    -- Used to format the buffer in an async way.
    if err ~= nil or result == nil then
        return
    end
    -- if
    --     vim.api.nvim_buf_get_var(ctx.bufnr, 'init_changedticr') == vim.api.nvim_buf_get_var(ctx.bufnr, 'changedtick')
    -- then
      local view = vim.fn.winsaveview()
      vim.lsp.util.apply_text_edits(result, ctx.bufnr)
      vim.fn.winrestview(view)
      if ctx.bufnr == vim.api.nvim_get_current_buf() then
        vim.b.saving_format = true
        vim.cmd [[update]]
        vim.b.saving_format = false
      end
    -- end
  end
EOF
endif
