alias g="git"
alias gti="git"
alias gls="git log --graph --pretty=format:'%C(bold red)%h%Creset [%Cblue%an%Creset] %s -%C(auto)%d%Creset %C(yellow)(%cr)%Creset'"
alias gll="git log --pretty=format:'%C(bold red)%h%Creset [%Cblue%an%Creset] %s -%C(auto)%d%Creset %C(yellow)(%cr)%Creset' --numstat"
alias glf="git log --pretty=full"
alias glm="git log -n 1 --pretty=%B"
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias glw="watch -c -n 1 -t git log --oneline --all --graph --decorate --color=always"

alias gcl="git clone"
alias gpl='git pull --rebase'
alias gf="git fetch --all --tags --prune"
alias gs='git status -sb'
alias gp='git push origin HEAD'
alias gpc='git push origin HEAD:refs/for/master'
alias grb="git rebase"
alias grbs="git rebase --skip"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias grbi="git rebase -i"
alias gm="git merge"
alias gms="git merge --skip"
alias gmc="git merge --continue"
alias gma="git merge --abort"
alias gmff="git merge --ff"
alias gmt="git mergetool"

alias ga="git add"
alias gaa="git add --all"
alias gst="git stash save --include-untracked"
alias gstp="git stash pop"
alias gstcl="git stash clear"
alias gres="git reset --mixed"
alias gress="git reset --soft"
alias gresh="git reset --hard"
alias greso="git fetch --prune && git reset --hard @{upstream}"
alias gundo="git reset $@ HEAD"

alias gbss="git bisect start"
alias gbsr="git bisect reset"
alias gbsg="git bisect good"
alias gbsb="git bisect bad"

alias gc='git commit -S'
alias gca='git commit -S --amend'
alias gac='git add --all && git commit -S -m'

alias gco='git checkout'
alias gcob='git checkout -b'
alias gcp="git cherry-pick -x"
alias gb='git branch'
alias gbr='git branch -D'

alias lg='lazygit'
