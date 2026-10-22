-- VSCode-specific config
local map = vim.keymap.set
local vscode = require('vscode')

-- Window key mappings (delegate to VSCode's own actions)
local actions = {
  ['<leader>w'] = 'workbench.action.files.save',
  ['<leader>q'] = 'workbench.action.closeWindow',
  ['<C-h>'] = 'workbench.action.focusLeftGroup',
  ['<C-j>'] = 'workbench.action.focusBelowGroup',
  ['<C-k>'] = 'workbench.action.focusAboveGroup',
  ['<C-l>'] = 'workbench.action.focusRightGroup',
}
for key, action in pairs(actions) do
  map('n', key, function() vscode.action(action) end)
end

-- LSP key mappings
map('n', 'gh', vim.lsp.buf.hover)
map('n', 'gd', vim.lsp.buf.definition)
map('n', 'gD', vim.lsp.buf.declaration)
map('n', 'gr', vim.lsp.buf.references)
map('n', 'gi', vim.lsp.buf.implementation)

-- Plugins
dofile(vim.env.DOTFILES .. '/nvim/configs/base-plugins.lua')()
