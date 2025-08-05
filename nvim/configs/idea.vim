https://www.cyberwizard.io/posts/the-ultimate-ideavim-setup/

" Go to code
nmap gh <Action>(QuickJavaDoc)
nmap <leader>gd <Action>(GotoDeclaration)
nmap <leader>gD <Action>(GotoTypeDeclaration)
nmap <leader>gi <Action>(GotoImplementation)
nmap <leader>gr <Action>(ShowUsages)
nmap <leader>gt <Action>(GotoTest)
nmap <leader>gf <Action>(Back)
nmap <leader>gb <Action>(Forward)

nmap gcc <Action>(CommentByLineComment)

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

set highlightedyank
