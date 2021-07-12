#!/bin/bash
if type antibody >/dev/null 2>&1; then
    echo 'Antibody already installed'
else
    case $SYSTEM_PACKAGE_MANAGER in
    brew)
        brew install getantibody/tap/antibody;;
    *)
        curl -sL https://git.io/antibody | bash -s;;
    esac
fi

if type antibody >/dev/null 2>&1; then
    antibody bundle < $DOTFILES/antibody/plugins.txt > $DOTFILES/antibody/zsh_plugins.zsh
fi
