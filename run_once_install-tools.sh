#!/bin/bash

source $HOME/.cargo/env
cd $(chezmoi source-path)
cargo install --path private_external_delta
cargo install --path private_external_ripgrep
cargo install --path private_external_zoxide
