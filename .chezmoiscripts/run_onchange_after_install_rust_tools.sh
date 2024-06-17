#!/bin/bash

source $HOME/.local/share/cargo/env
cargo install git-delta
cargo install ripgrep
cargo install zoxide
cargo install alacritty

update-desktop-database --quiet
exit 0

