#!/bin/sh

export RUSTUP_HOME=$HOME/.local/share/rustup
export CARGO_HOME=$HOME/.local/share/cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

