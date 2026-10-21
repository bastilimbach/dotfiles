# Resolve Homebrew's prefix without spawning `brew` (~60ms each) on every startup.
BREW_PREFIX=${HOMEBREW_PREFIX:-/opt/homebrew}
[[ -d $BREW_PREFIX ]] || BREW_PREFIX=/home/linuxbrew/.linuxbrew

# fzf
[[ $- == *i* ]] && source "$BREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
