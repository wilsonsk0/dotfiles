if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx TMPDIR ~/.local/tmp

    pyenv init - | source
    pyenv virtualenv-init - | source
    fzf --fish | source
    zoxide init --cmd cd fish | source
    direnv hook fish | source
    starship init fish | source
end

