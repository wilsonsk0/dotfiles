#!/bin/bash

source $HOME/.cargo/env

cargo install git-delta
cargo install ripgrep
cargo install zoxide

(
    echo Installing fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
)
(
    echo Installing pyenv
    curl https://pyenv.run | bash
)
(
    echo Installing tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
)

