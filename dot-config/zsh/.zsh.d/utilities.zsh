#!/usr/bin/env zsh

# direnv
eval "$(direnv hook zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
eval "$(fzf --zsh)"
if [[ -n $TMUX ]]; then
    # if tmux, make fzf use tmux popups
    fzf() {
        command fzf --tmux "$@"
    }
fi
