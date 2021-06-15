# Defined interactively
function __fish_list_current_token --description 'List contents of token under the cursor if it is a directory, otherwise list the contents of the current directory'
    set -l val (eval echo (commandline -t))
    printf "\n"
    if test -d $val
        exa -la --icons $val
    else
        set -l dir (dirname -- $val)
        if test $dir != . -a -d $dir
            exa -la --icons $dir
        else
            exa -la --icons
        end
    end

    set -l line_count (count (fish_prompt))
    if test $line_count -gt 1
        for x in (seq 2 $line_count)
            printf "\n"
        end
    end

    commandline -f repaint
end
