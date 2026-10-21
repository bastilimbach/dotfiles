# Environment variables
# Sourced early (before zinit) so PATH and friends are available to everything.

export EDITOR=code
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export CLICOLOR=true
export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export HOMEBREW_NO_AUTO_UPDATE=1

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export JAVA_HOME="/Library/Java/JavaVirtualMachines/sapmachine-21.jdk/Contents/Home"
