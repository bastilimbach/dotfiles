alias gti="git"
alias gls="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gll="git log --graph --oneline --decorate --all"
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias glw="watch -c -n 1 -t git log --oneline --all --graph --decorate --color=always"

alias gcl="git clone"
alias gpl='git pull --rebase'
alias gf="git fetch --prune"
alias gs='git status -sb'
alias gp='git push origin HEAD'
alias grb="git rebase"
alias grbi="git rebase -i HEAD~$1"

alias ga="git add"
alias gaa="git add --all"
alias gst="git stash save --include-untracked"
alias gres="git reset"
alias gundo="git reset $@ HEAD"

alias gc='git commit -S'
alias gca='git commit -S -a'
alias gac='git add --all && git commit -S -m'

alias gco='git checkout'
alias gb='git branch'


