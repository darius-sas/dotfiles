function n
    set dst (z -e $argv)
    set success $status
    if test "$success" -ne 0
        echo "Directory not in z index. Doing nothing."
        return 1
    end
    cd $dst
    nvim .
end
