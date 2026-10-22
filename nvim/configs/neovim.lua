-- Neovim-specific config (not VSCode, not IdeaVIM)
vim.opt.spell = true
vim.opt.spelllang = { 'en', 'de' }
vim.opt.spellsuggest = { 'best', '9' }

-- --------------
-- Key mappings
-- --------------
local map = vim.keymap.set
map('n', '<leader>v', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>xx', '<cmd>TroubleToggle<CR>')

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fa', '<cmd>Telescope find_files no_ignore=true<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>')
map('n', '<leader>fd', '<cmd>Telescope lsp_document_diagnostics<cr>')

-- Floaterm
map('n', '<leader>t', ':FloatermToggle<CR>', { silent = true })
map('n', '<leader>n', ':FloatermPrev<CR>', { silent = true })
map('n', '<leader>m', ':FloatermNext<CR>', { silent = true })
map('n', '<leader>k', ':FloatermKill<CR>', { silent = true })
map('n', '<leader>x', vim.diagnostic.open_float)

-- LSP
map('n', 'gh', vim.lsp.buf.hover)
map('n', 'gd', vim.lsp.buf.definition)
map('n', 'gD', vim.lsp.buf.declaration)
map('n', 'gr', vim.lsp.buf.references)
map('n', 'gi', vim.lsp.buf.implementation)

-- Navigate between windows (split in the move direction if there's no window there)
local function win_move(key)
  local curwin = vim.fn.winnr()
  vim.cmd('wincmd ' .. key)
  if curwin == vim.fn.winnr() then
    if key == 'h' or key == 'l' then
      vim.cmd('wincmd v')
    else
      vim.cmd('wincmd s')
    end
    vim.cmd('wincmd ' .. key)
  end
end
map('n', '<C-h>', function() win_move('h') end, { silent = true })
-- map('n', '<C-j>', function() win_move('j') end, { silent = true })
-- map('n', '<C-k>', function() win_move('k') end, { silent = true })
map('n', '<C-l>', function() win_move('l') end, { silent = true })

-- --------------
-- Autocommands
-- --------------
local trim_group = vim.api.nvim_create_augroup('TrimTrailingWhiteSpace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = trim_group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})
vim.api.nvim_create_autocmd('BufWritePre', {
  group = trim_group,
  pattern = '*',
  command = [[%s/\n\+\%$//e]],
})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 700 }
  end,
})

-- --------------
-- Plugins
-- --------------
local setup_plugins = dofile(vim.env.DOTFILES .. '/nvim/configs/base-plugins.lua')
setup_plugins({
  -- Theme: load at startup so colors are present immediately.
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha
    end,
    config = function()
      vim.cmd.colorscheme('catppuccin')
      vim.opt.background = 'dark'
      vim.opt.termguicolors = true
      vim.cmd [[
        highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
        highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
        highlight Sneak guifg='#afff5f' gui=underline ctermfg=81 cterm=underline
        highlight SneakLabel guifg='#afff5f' gui=underline ctermfg=81 cterm=underline
        highlight SneakLabelMask guifg=NONE ctermfg=NONE cterm=nocombine
        highlight DiffAdd guibg='#164846'
        highlight DiffDelete guibg='#823c41'
        highlight DiffChange guibg='#394b70'
      ]]
    end,
  },

  -- Displays a right buffer to view register content & select the desired register before pasting.
  { 'junegunn/vim-peekaboo', event = 'VeryLazy' },

  -- Statusbar
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
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
    end,
  },

  -- Display indentation lines.
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    config = true,
  },

  -- Automatically inserts matching brackets & quotes.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true
      }
    end,
  },

  -- Sidebar which displays the current working-tree (files).
  {
    'kyazdani42/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    dependencies = { 'kyazdani42/nvim-web-devicons' }, -- Icons for nvim-tree.
    config = function()
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
    end,
  },

  -- Display diagnostics in a pretty list.
  {
    'folke/trouble.nvim',
    cmd = 'TroubleToggle',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('trouble').setup {
        mode = 'document_diagnostics'
      }
    end,
  },

  -- Use the terminal in a floating/popup window.
  {
    'voldikss/vim-floaterm',
    cmd = { 'FloatermToggle', 'FloatermNew', 'FloatermNext', 'FloatermPrev', 'FloatermKill' },
    init = function()
      vim.g.floaterm_title = '($1|$2)'
    end,
  },

  -- Single tabpage interface for easily cycling through git diffs.
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Dependency for a lot of lua plugins. Packages many lua utility functions.
    config = function()
      require('diffview').setup {
        enhanced_diff_hl = true
      }
    end,
  },

  -- Fuzzy file finder.
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- Makes fuzzy finding in telescope faster.
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
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
    end,
  },

  -- Syntax highlighting and other stuff.
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master', -- classic API (require('nvim-treesitter.configs')); 'main' is a rewrite
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
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
    end,
  },

  -- Autocompletion plugin.
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/vim-vsnip',      -- Snippet engine used by nvim-cmp. Used to insert code snippets.
      'hrsh7th/cmp-nvim-lsp',   -- LSP source for nvim-cmp. Required to display lsp content in the autocomplete popover.
      'hrsh7th/cmp-vsnip',      -- VSnip source for nvim-cmp.
      'hrsh7th/cmp-buffer',     -- Buffer source for nvim-cmp.
      'onsails/lspkind-nvim',   -- Adds pictograms to completion popups.
    },
    config = function()
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
    end,
  },

  -- Used to configure neovim lsp for different lsp servers.
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',       -- LSP source for nvim-cmp (provides completion capabilities).
      'ray-x/lsp_signature.nvim',   -- Shows function signature when you type.
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

      -- Defaults applied to every server (nvim 0.11+ vim.lsp.config API).
      -- nvim-lspconfig ships the per-server defaults (cmd, root markers, filetypes);
      -- these calls extend them, and vim.lsp.enable() activates the servers.
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config('ts_ls', {
        init_options = {
          preferences = {
            disableSuggestions = true
          }
        },
        on_attach = function (client)
          -- Disable document formatting for tsserver as efm will do this
          client.server_capabilities.document_formatting = false
          on_lsp_attach(client)
        end
      })

      -- vim.lsp.config('vuels', {})
      vim.lsp.config('volar', {
        on_attach = on_lsp_attach,
        init_options = {
          typescript = {
            tsdk = '/usr/local/lib/node_modules/typescript/lib'
          }
        }
      })
      vim.lsp.config('rust_analyzer', {
        on_attach = on_lsp_attach,
      })
      vim.lsp.config('angularls', {
        on_attach = on_lsp_attach,
      })
      -- vim.lsp.config('emmet_ls', {
      --   on_attach = on_lsp_attach,
      -- })
      vim.lsp.config('prismals', {
        on_attach = on_lsp_attach,
      })

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

      vim.lsp.config('efm', {
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
      })

      vim.lsp.enable({ 'ts_ls', 'volar', 'rust_analyzer', 'angularls', 'prismals', 'efm' })

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
    end,
  },

  -- Automatically creates sessions on exit & restores them on start.
  -- (disabled for now — auto-restore was the main startup-latency cost)
  -- {
  --   'rmagatti/auto-session',
  --   config = function()
  --     require('auto-session').setup {
  --       pre_save_cmds = { 'tabdo NvimTreeClose' }
  --     }
  --   end,
  -- },
})
