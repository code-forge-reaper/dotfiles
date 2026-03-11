#!/usr/bin/env sh
# build.sh - simple script for building things


# Capture the PID of the script itself
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

cmd(){
    echo "$@"
    # Execute the command and capture its output and status
    msg=$("$@" 2>&1)
    status=$?
    if [ $status -ne 0 ]; then
        raise "An error happened: ${msg}"
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

find_headers(){
    names="$@"
    # Retrieve compiler flags for the given names using pkg-config
    echo "$(pkg-config --cflags $names)"
}

find_libs(){
    names="$@"
    # Retrieve linker flags for the given names using pkg-config
    echo "$(pkg-config --libs $names)"
}

# Register errorHandler as sh's error trap
trap 'errorHandler "$0:$LINENO"' ERR
