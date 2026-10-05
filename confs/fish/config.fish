~/scripts/gtools g fish | source

# functions
function kitty-reload
    kill -SIGUSR1 (pidof kitty)
end

function original
    if test (count $argv) -eq 0
        echo "original:"
        echo "runs the original command, be it in /usr/bin /bin or in some other folder,"
        echo "Usage: original <command> [arguments]"
        return 1
    end

    set cmd $argv[1]
    set -e argv[1]
    command $cmd $argv
end

function whoowns
    if test (count $argv) -eq 0
        echo whoowns
        echo " shows you who is the owner of a file or folder"
        echo " e.g: ~/ owner's would be you, (whoami)"
        echo "whoowns <file or folder>"
        return 1
    end
    stat -c '%U' $argv[1]
end

function findEdit
    if test (count $argv) -eq 0
        echo "running fzf on current folder"
        edit $(fzf)
    else
        edit $(fzf $argv[1])
    end
end

function yt
    if test (count $argv) -eq 0
        echo "Usage: yt <url(s)>"
        return 1
    end

    for url in $argv
        if string match -q "*playlist?list=*" $url
            yt-dlp -o "$HOME/Music/%(uploader)s/%(playlist_title)s/%(title)s [%(id)s].%(ext)s" $url
        else
            yt-dlp -o "$HOME/Music/%(uploader)s/%(title)s [%(id)s].%(ext)s" $url
        end
    end
end

function fish_greeting

end

eval (uni-path.py fish) # de-dups paths, in case some random thing added to path after gtools ran

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /home/cross/.config/yarn/global/node_modules/tabtab/.completions/electron-forge.fish ]; and . /home/cross/.config/yarn/global/node_modules/tabtab/.completions/electron-forge.fish