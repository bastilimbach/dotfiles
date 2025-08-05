" VSCode-specific config
nnoremap <leader>w <Cmd>lua require('vscode').action('workbench.action.files.save')<CR>
nnoremap <leader>q <Cmd>lua require('vscode').action('workbench.action.closeWindow')<CR>
nnoremap <C-h> <Cmd>lua require('vscode').action('workbench.action.focusLeftGroup')<CR>
nnoremap <C-j> <Cmd>lua require('vscode').action('workbench.action.focusBelowGroup')<CR>
nnoremap <C-k> <Cmd>lua require('vscode').action('workbench.action.focusAboveGroup')<CR>
nnoremap <C-l> <Cmd>lua require('vscode').action('workbench.action.focusRightGroup')<CR>

nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
