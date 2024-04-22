#!/bin/bash

cd $(chezmoi source-path)/.chezmoidata
cargo install --path delta
cargo install --path ripgrep
cargo install --path zoxide
