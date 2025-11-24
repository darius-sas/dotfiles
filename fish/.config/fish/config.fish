set fish_greeting # Erase greeting message
if status is-interactive
    # Commands to run in interactive sessions can go here
    fzf --fish | source
    # jump shell fish | source
    # pyenv takes a bit to run
    # pyenv init - fish | source
    # Scaleway CLI autocomplete initialization.
    # eval (scw autocomplete script shell=fish)
end

