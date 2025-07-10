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
" Plugin config
" --------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:sneak#label = 1
let g:floaterm_title = '($1|$2)'

lua <<EOF
require('hardtime').setup {
  disable_mouse = false
}

require('Comment').setup {}
require('nvim-autopairs').setup { check_ts = true }
require('auto-session').setup { pre_save_cmds = {'tabdo NvimTreeClose'} }
require('nvim-tree').setup {
  diagnostics = { enable = true },
  view = { adaptive_size = true },
  git = { ignore = false },
}
require('trouble').setup { mode = 'document_diagnostics' }
require('lualine').setup {
  options = { theme = 'iceberg_dark' },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', cond = function() return vim.fn.winwidth(0) > 80 end },
      { 'diff', cond = function() return vim.fn.winwidth(0) > 80 end },
      { 'diagnostics', sources = { 'nvim_diagnostic' }, cond = function() return vim.fn.winwidth(0) > 50 end },
    },
    lualine_c = { 'filename' },
    lualine_x = { { 'encoding', cond = function() return vim.fn.winwidth(0) > 100 end } },
    lualine_y = { { 'progress', cond = function() return vim.fn.winwidth(0) > 100 end } },
    lualine_z = { { 'location', cond = function() return vim.fn.winwidth(0) > 100 end } },
  },
  extensions = { 'nvim-tree' },
}
local telescope = require('telescope')
telescope.setup {
  defaults = {
    file_ignore_patterns = { '.git' },
    path_display = { 'truncate' },
    mappings = {
      i = { ['<ESC>'] = require('telescope.actions').close },
      n = { ['q'] = require('telescope.actions').close },
    },
  },
  pickers = { find_files = { hidden = true } },
  extensions = { fzf = { fuzzy = true, override_generic_sorter = false, override_file_sorter = true } },
}
telescope.load_extension('fzf')
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'html','javascript','typescript','json','json5','jsonc','regex','rust','vim','vue','yaml','css','bash','lua','prisma'
  },
  highlight = { enable = true },
  indent = { enable = true },
  context_commentstring = { enable = true },
}
local parsers = require('nvim-treesitter.parsers')
local configs = parsers.get_parser_configs()
local ft_str = table.concat(
  vim.tbl_map(function(ft) return configs[ft].filetype or ft end, parsers.available_parsers()), ',')
vim.cmd('autocmd Filetype ' .. ft_str .. ' setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()')
require('diffview').setup { enhanced_diff_hl = true }
local cmp = require('cmp')
cmp.setup {
  snippet = { expand = function(args) vim.fn['vsnip#anonymous'](args.body) end },
  sources = { { name = 'nvim_lsp' }, { name = 'vsnip' }, { name = 'buffer' } },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  },
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = ({ nvim_lsp = "[LSP]", vsnip = "[Snippet]", buffer = "[Buffer]" })
    }),
  },
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_lsp_attach = function (client)
  if client.server_capabilities.document_formatting then
    vim.cmd [[augroup Format]]
    vim.cmd [[autocmd! * <buffer>]]
    vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.cmd [[augroup END]]
  end
  require('lsp_signature').on_attach({
    bind = true,
    handler_opts = { border = 'none' },
    hint_enable = false,
    padding = ' '
  })
end
local lsp = require('lspconfig')
lsp.ts_ls.setup {
  init_options = { preferences = { disableSuggestions = true } },
  capabilities = capabilities,
  on_attach = function (client)
    client.server_capabilities.document_formatting = false
    on_lsp_attach(client)
  end
}
lsp.volar.setup {
  capabilities = capabilities,
  on_attach = on_lsp_attach,
  init_options = { typescript = { tsdk = '/usr/local/lib/node_modules/typescript/lib' } }
}
lsp.rust_analyzer.setup { capabilities = capabilities, on_attach = on_lsp_attach }
lsp.angularls.setup { capabilities = capabilities, on_attach = on_lsp_attach }
lsp.prismals.setup { capabilities = capabilities, on_attach = on_lsp_attach }
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
  init_options = { documentFormatting = true },
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
vim.lsp.handlers['textDocument/formatting'] = function(err, result, ctx)
  if err ~= nil or result == nil then return end
  if vim.api.nvim_buf_get_var(ctx.bufnr, "init_changedtick") == vim.api.nvim_buf_get_var(ctx.bufnr, "changedtick") then
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

require('catppuccin').setup {
  integrations = {
    telescope = true,
    nvimtree = { enabled = true },
    cmp = true
  },
}
EOF
let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha
colorscheme catppuccin
set background=dark
set termguicolors
