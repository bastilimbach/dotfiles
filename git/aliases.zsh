alias gti="git"
alias gls="git log --graph --pretty=format:'%C(bold red)%h%Creset [%Cblue%an%Creset] %s -%C(auto)%d%Creset %C(yellow)(%cr)%Creset'"
alias gll="git log --pretty=format:'%C(bold red)%h%Creset [%Cblue%an%Creset] %s -%C(auto)%d%Creset %C(yellow)(%cr)%Creset' --numstat"
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias glw="watch -c -n 1 -t git log --oneline --all --graph --decorate --color=always"

alias gcl="git clone"
alias gpl='git pull --rebase'
alias gf="git fetch --prune"
alias gs='git status -sb'
alias gp='git push origin HEAD'
alias gpc='git push origin HEAD:refs/for/master'
alias grb="git rebase"
alias grbi="git rebase -i HEAD~$1"

alias ga="git add"
alias gaa="git add --all"
alias gst="git stash save --include-untracked"
alias gstp="git stash pop"
alias gstcl="git stash clear"
alias gres="git reset"
alias greso="git reset --hard origin/HEAD"
alias gundo="git reset $@ HEAD"

alias gc='git commit -S'
alias gca='git commit -S -a'
alias gac='git add --all && git commit -S -m'

alias gco='git checkout'
alias gb='git branch'
