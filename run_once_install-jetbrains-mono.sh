#!/bin/bash

cd /tmp
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
mkdir JetBrainsMono
tar -xf JetBrainsMono.tar.xz -C JetBrainsMono
fc-cache JetBrainsMono

rm -rf JetBrainsMono/
rm JetBrainsMono.tar.xz