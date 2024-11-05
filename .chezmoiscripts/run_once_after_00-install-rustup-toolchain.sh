#!/bin/sh

source $HOME/.profile

if command -v rustup > /dev/null 2>&1; then
  echo "rustup toolchain already installed"
else
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
rustup default stable
