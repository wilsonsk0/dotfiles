#!/bin/bash

source $HOME/.cargo/env
cd $(chezmoi source-path)

cargo install git-delta
cargo install ripgrep
cargo install zoxide

~/.fzf/install --key-bindings --completion --update-rc
(
    cd ~/.pyenv
    ./src/configure
    make -C src
)

