upd() {
    local lt=$(color \#0ff $'\n> ')
    # %D should be shortened when possible/needed
    # /some/path/name -> /s/p/name
    local g=$(color green '${(e)git_info[prompt]}')
    local DURATION=$''

    if [[ -n "$duration_info" ]]; then
        local cmd=("${(@z)$(fc -ln -1)}")
        DURATION=$'\n["'"$cmd[1]"'" took: '"$duration_info"']'
    fi
    local p=(
    "$U@$M in $D$g [%T]$JOBS"
    $DURATION
    $lt
    )

    PS1=$p
}
add-zsh-hook precmd upd
upd
