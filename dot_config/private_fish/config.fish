if status is-interactive
    # Commands to run in interactive sessions can go here
    pyenv init - | source
    pyenv virtualenv-init - | source
    fzf --fish | source
    zoxide init --cmd cd fish | source
    goenv init - | source

    fish_add_path -gpP $GOROOT/bin
    fish_add_path -gaP $GOPATH/bin 

    direnv hook fish | source
    starship init fish | source
end

