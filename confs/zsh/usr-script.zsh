original() {
    if (( $# == 0 )); then
        echo "original:"
        echo "runs the original command, be it in /usr/bin /bin or in some other folder,"
        echo "Usage: original <command> [arguments]"
        return 1
    fi

    local cmd="$1"
    shift
    command "$cmd" "$@"
}

whoowns() {
    if (( $# == 0 )); then
        echo "whoowns"
        echo " shows you who is the owner of a file or folder"
        echo " e.g: ~/ owner's would be you, (whoami)"
        echo "whoowns <file or folder>"
        return 1
    fi

    stat -c '%U' "$1"
}

findEdit() {
    if (( $# == 0 )); then
        echo "running fzf on current folder"
        edit "$(fzf)"
    else
        edit "$(fzf "$1")"
    fi
}

yt() {
    if (( $# == 0 )); then
        echo "Usage: yt <url(s)>"
        return 1
    fi

    local url
    for url in "$@"; do
        if [[ "$url" == *"playlist?list="* ]]; then
            yt-dlp \
                -o "$HOME/Music/%(uploader)s/%(playlist_title)s/%(title)s [%(id)s].%(ext)s" \
                "$url"
        else
            yt-dlp \
                -o "$HOME/Music/%(uploader)s/%(title)s [%(id)s].%(ext)s" \
                "$url"
        fi
    done
}