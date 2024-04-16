# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -f $HOME/.cargo/env ]; then
    . "$HOME/.cargo/env"
elif [ -f $HOME/.cargo/bin ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# add local go bin to path
if [ -f $HOME/go/bin ]; then
    PATH="$PATH:$HOME/go/bin"
fi

# terminal prompt
export PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ "
if [ -f $HOME/.git-prompt.sh ]; then
	. $HOME/.git-prompt.sh
	export PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1 ' (%s)')\n\$ "
fi

if [ -f ~/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v > /dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

alias ls="ls -lxF --color=auto"
alias ll="ls -lh"
alias lla="ls -lha"
alias vim="nvim"

