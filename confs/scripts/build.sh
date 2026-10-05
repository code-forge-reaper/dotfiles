#!/usr/bin/env bash
# build.sh - simple script for building things

if [[ $- == *i* || "${BASH_SOURCE[0]}" == "$0" ]]; then
	echo "DO NOT FUCKING SOURCE NOR RUN THIS IN INTERACTIVE SHELLS"
	printf "ONLY VALID USE:\n> cat file.bash\nsource ${BASH_SOURCE}\n"
	exit 1
fi

# Capture the PID of the caller(current shell/interpreter)
# AKA, the thing that starts when you run "sh buildSomething.sh"
pid=$$
echo "Script PID = $pid"

errorHandler(){
    echo "An error occurred while building the project at line $LINENO"
    echo "Error: $1"

    # check for cleanUp function
    if declare -f cleanUp > /dev/null; then
        cleanUp
    else
        echo "No cleanUp function defined."
    fi
}

raise(){
    errorHandler "$1"
    echo "Killing process $pid due to error."
    kill -TERM "$pid" # Use TERM signal for a graceful shutdown
    exit 1
}

older(){
    if [[ ! -e "$1"  || ! -e "$2" ]]; then
        return 0
    else
        local v1=$(stat "$1" -c %Z)
        local v2=$(stat "$2" -c %Z)
        return $([ $v1 -gt $v2 ])
    fi
}

cmd(){
    echo "+ $*" >&2
    if ! "$@"; then
        raise "Command failed: $*"
    fi
}

var(){
    # Set a variable with the given name and value
    name=$1           # Assign the first argument to `name`
    shift             # Remove the first argument from the list
    val="$@"          # Assign the remaining arguments to `val`
    echo "${name} = ${val}"
    eval "$name='$val'"  # Dynamically set the variable using `eval`
}

exists(){
    if command -v "$1" >/dev/null 2>&1; then
        echo "$1 found"
        return 0
    else
        echo "$1 not found"
        return 1
    fi
}

find-headers(){
    names="$@"
    # Retrieve compiler flags for the given names using pkg-config
    echo "$(pkg-config --cflags $names)"
}

find-libs(){
    names="$@"
    # Retrieve linker flags for the given names using pkg-config
    echo "$(pkg-config --libs $names)"
}

# Register errorHandler as sh's error trap
trap 'errorHandler "$0:$LINENO"' ERR
