" Neovim-specific config (not VSCode, not IdeaVIM)
set spell
set spelllang=en,de
set spellsuggest=best,9

" Plugin keymaps
nnoremap <leader>v <cmd>NvimTreeToggle<CR>
nnoremap <leader>xx <cmd>TroubleToggle<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fa <cmd>Telescope find_files no_ignore=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fd <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <silent> <leader>t :FloatermToggle<CR>
nnoremap <silent> <leader>n :FloatermPrev<CR>
nnoremap <silent> <leader>m :FloatermNext<CR>
nnoremap <silent> <leader>k :FloatermKill<CR>
nnoremap <leader>x <cmd>lua vim.diagnostic.open_float()<CR>

" LSP keymaps
nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>

" --------------
" Autocommands
" --------------
augroup TrimTrailingWhiteSpace
  au!
  au BufWritePre * %s/\s\+$//e
  au BufWritePre * %s/\n\+\%$//e
augroup END

augroup HighlightYank
  au!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

" --------------
" Plugin config
" --------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:sneak#label = 1
let g:floaterm_title = '($1|$2)'

lua <<EOF
  -- Hardtime
  require('hardtime').setup {
    disable_mouse = false
  }

  -- Comment
  require('Comment').setup {}

  -- Autopairs
  require('nvim-autopairs').setup {
    check_ts = true
  }

  -- Auto session
  require('auto-session').setup {
    pre_save_cmds = {'tabdo NvimTreeClose'}
  }

  -- Nvim Tree
  require('nvim-tree').setup {
    diagnostics = {
      enable = true
    },
    view = {
      adaptive_size = true
    },
    git = {
      ignore = false
    },
  }

  -- Trouble
  require('trouble').setup {
    mode = 'document_diagnostics'
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
          sources = { 'nvim_diagnostic' },
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
      'bash',
      'lua',
      'prisma'
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

  -- DiffView
  require('diffview').setup {
    enhanced_diff_hl = true
  }

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
      { name = 'buffer' }
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
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- LSP config
  local on_lsp_attach = function (client)
    -- If the lsp server support formatting format the buffer on save.
    if client.server_capabilities.document_formatting then
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
  lsp.ts_ls.setup {
    init_options = {
      preferences = {
        disableSuggestions = true
      }
    },
    capabilities = capabilities,
    on_attach = function (client)
      -- Disable document formatting for tsserver as efm will do this
      client.server_capabilities.document_formatting = false
      on_lsp_attach(client)
    end
  }

  -- lsp.vuels.setup {}
  lsp.volar.setup {
    capabilities = capabilities,
    on_attach = on_lsp_attach,
    init_options = {
      typescript = {
        tsdk = '/usr/local/lib/node_modules/typescript/lib'
      }
    }
  }
  lsp.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  }
  lsp.angularls.setup {
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  }
  -- lsp.emmet_ls.setup {
  --   capabilities = capabilities,
  --   on_attach = on_lsp_attach,
  -- }
  lsp.prismals.setup {
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  }

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
    capabilities = capabilities,
    on_attach = on_lsp_attach,
    filetypes = { 'javascript', 'typescript' },
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
    -- https://github.com/lukas-reineke/dotfiles/blob/e84ddf819b7b279dd77b558a65421feca5543180/vim/lua/lsp/handlers.lua
    if err ~= nil or result == nil then
      return
    end
    if
      vim.api.nvim_buf_get_var(ctx.bufnr, "init_changedtick") == vim.api.nvim_buf_get_var(ctx.bufnr, "changedtick")
      then
      local view = vim.fn.winsaveview()
      vim.lsp.util.apply_text_edits(result, ctx.bufnr)
      vim.fn.winrestview(view)
      if ctx.bufnr == vim.api.nvim_get_current_buf() then
        vim.b.saving_format = true
        vim.cmd [[update]]
        vim.b.saving_format = false
      end
    end
  end
EOF

let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha
colorscheme catppuccin
set background=dark
set termguicolors
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
highlight Sneak guifg='#afff5f' gui=underline ctermfg=81 cterm=underline
highlight SneakLabel guifg='#afff5f' gui=underline ctermfg=81 cterm=underline
highlight SneakLabelMask guifg=NONE ctermfg=NONE cterm=nocombine
highlight DiffAdd guibg='#164846'
highlight DiffDelete guibg='#823c41'
highlight DiffChange guibg='#394b70'
