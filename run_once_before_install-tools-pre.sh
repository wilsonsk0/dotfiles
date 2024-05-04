#!/bin/bash

echo Installing rustup
export RUSTUP_HOME=$HOME/.local/share/rustup
export CARGO_HOME=$HOME/.local/share/cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo Installing fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/share/fzf
~/.local/share/fzf/install --key-bindings --completion --no-update-rc --xdg

echo Installing pyenv
export PYENV_ROOT=$HOME/.local/share/pyenv
curl https://pyenv.run | bash

echo Installing tpm
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm

echo Installing oh-my-zsh
installer="$(mktemp --tmpdir ohmyzshinstaller_XXXXXX.sh)"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh > $installer
export ZSH=$HOME/.local/share/oh-my-zsh
cat $installer | sh -s -- --unattended --keep-zshrc
rm $installer

mkdir -p $HOME/.local/share/zsh
git clone https://github.com/sindresorhus/pure.git "$HOME/.local/share/zsh/pure"

