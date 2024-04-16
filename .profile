# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Tooling ================================================
# cargo
if [ -f $HOME/.cargo/env ]; then
    . "$HOME/.cargo/env"
else [ -d $HOME/.cargo/bin ]; then
    PATH="$PATH:$HOME/.carg/bin"
fi

# go
if [ -d /usr/local/go/bin ]; then
    PATH="$PATH:/usr/local/go/bin"
fi
if [ -d $HOME/go/bin ]; then
    PATH="$PATH:$HOME/go/bin"
fi

# JetBrains tools
if [ -d $HOME/.local/share/JetBrains/Toolboc/scripts ]; then
    PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
fi

# nvm
if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi

export CPLUS_INCLUDE_PATH=/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11

