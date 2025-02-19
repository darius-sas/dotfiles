if status is-interactive
    # Commands to run in interactive sessions can go here
    fzf --fish | source
    jump shell fish | source
    pyenv init - fish | source
end
