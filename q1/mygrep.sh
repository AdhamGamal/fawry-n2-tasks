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

add_n_flag=false
add_v_flag=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n)
            if [[ "$add_n_flag" == true ]]; then
                error_exit "Repeated option '-n'"
            fi
            grep_command+=" -n"
            add_n_flag=true
            shift
            ;;
        -v)
            if [[ "$add_v_flag" == true ]]; then
                error_exit "Repeated option '-v'"
            fi
            grep_command+=" -v"
            add_v_flag=true
            shift
            ;;
        -nv|-vn)
            if [[ "$add_n_flag" == true || "$add_v_flag" == true ]]; then
                error_exit "Repeated option '-n' or '-v' (combined '-nv' or '-vn')"
            fi
            grep_command+=" -n -v"
            add_n_flag=true
            add_v_flag=true
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
