#!/bin/bash

error_exit() {
    echo "Error: $1" >&2
    usage
    exit 1
}

usage() {
    echo "Usage: $0 [OPTIONS] QUERY FILE" >&2
}

# Main script
grep_command="grep "
query=""
file=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n)
            grep_command+=" -n"
            shift
            ;;
        -v)
            grep_command+=" -v"
            shift
            ;;
        -nv|-vn)
            grep_command+=" -n -v"
            shift
            ;;
        -*)
            error_exit "Invalid option: $1" >&2
            ;;
        *)
            if [[ -z "$query" && ! -e "$1" ]]; then
                query="$1"
            elif [[ -z "$file" && -e "$1" ]]; then
                file="$1"
            else
                error_exit "Unexpected argument '$1'"
            fi
            shift
            ;;
    esac
done

# Final validations
[[ -z "$query" ]] && error_exit "Missing search query"
[[ -z "$file" ]] && error_exit "Missing file"
[[ ! -r "$file" ]] && error_exit "No read permission for '$file'"

# Execute grep command
$grep_command "$query" "$file"
