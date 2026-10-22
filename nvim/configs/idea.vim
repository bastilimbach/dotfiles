" https://www.cyberwizard.io/posts/the-ultimate-ideavim-setup/

" Emulated plugins. See IdeaVim Wiki: https://github.com/JetBrains/ideavim/wiki/IdeaVim-Plugins
set surround
set commentary
set targets
set highlightedyank
Plug 'justinmk/vim-sneak'        " sneak has no `set` form
let g:sneak#label = 1
set quickscope                 " requires the IdeaVim-Quickscope IDE plugin
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Go to code
nmap gh <Action>(QuickJavaDoc)
nmap <leader>gd <Action>(GotoDeclaration)
nmap <leader>gD <Action>(GotoTypeDeclaration)
nmap <leader>gi <Action>(GotoImplementation)
nmap <leader>gr <Action>(ShowUsages)
nmap <leader>gt <Action>(GotoTest)
nmap <leader>gf <Action>(Back)
nmap <leader>gb <Action>(Forward)

" File navigation
nmap <leader>ff <action>(GotoFile)
nmap <leader>fr <action>(RecentFiles)
nmap <leader>fc <action>(FindInPath)
nmap <leader><leader> <Action>(RecentFiles)
nmap <leader>fl <action>(RecentLocations)
nmap <leader>fs <action>(NewScratchFile)

" Refactoring
nmap <leader>rn <Action>(RenameElement)
nmap <leader>rm <Action>(ExtractMethod)
nmap <leader>rv <Action>(IntroduceVariable)
nmap <leader>rf <Action>(IntroduceField)
nmap <leader>rs <Action>(ChangeSignature)
nmap <leader>rr <Action>(Refactorings.QuickListPopupAction)

" Window navigation
nmap <C-h> <Action>(PrevSplitter)
nmap <C-l> <Action>(NextSplitter)
