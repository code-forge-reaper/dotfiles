{
    find . -mindepth 2 \( -type d -o -type f \) -name .git -printf '%h\n' |
        sed 's|^\./||'
        echo *.elc
        echo *.eln
} | sort -u >> .gitignore

printf "%s\n" $(cat .gitignore | uniq) > .gitignore
