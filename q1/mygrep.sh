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
query=""
file=""

show_line_number=false
show_invalid_match=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n)
            [[ "$show_line_number" == true ]] && error_exit "Repeated option '-n'"
            show_line_number=true
            shift
            ;;
        -v)
            [[ "$show_invalid_match" == true ]] && error_exit "Repeated option '-v'"
            show_invalid_match=true
            shift
            ;;
        -nv|-vn)
            [[ "$show_line_number" == true || "$show_invalid_match" == true ]] && error_exit "Repeated option in '-nv'"
            show_line_number=true
            show_invalid_match=true
            shift
            ;;
        -*)
            error_exit "Invalid option: $1"
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

# Execute grep
# Read the file line by line
line_number=1
while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == *"$query"* && "$show_invalid_match" == false ]]; then
        if [[ "$show_line_number" == true ]]; then
            echo "$line_number:$line"
        else
            echo "$line"
        fi
    elif [[ "$line" != *"$query"* && "$show_invalid_match" == true ]]; then
        if [[ "$show_line_number" == true ]]; then
            echo "$line_number:$line"
        else
            echo "$line"
        fi
    fi
    ((line_number++))
done < "$file"
