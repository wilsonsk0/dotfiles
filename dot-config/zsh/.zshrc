autoload -Uz compinit 
compinit

autoload -Uz promptinit
promptinit
prompt default

# zstyle ':antidote:bundle' use-friendly-names 'yes'
source $ZDOTDIR/.antidote/antidote.zsh
antidote load

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# if tmux, make fzf use tmux popups
if [[ -n $TMUX ]]; then
    fzf() {
        command fzf --tmux "$@"
    }
fi

