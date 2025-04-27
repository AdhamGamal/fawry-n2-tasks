#!/bin/bash

error_exit() {
    echo "Error: $1" >&2
    echo "Use '$0 --help' for usage information." >&2
    exit 1
}

show_help() {
    echo "Usage: $0 [OPTIONS] QUERY FILE"
    echo "Search for text in a file (simple grep replacement)"
    echo
    echo "Options:"
    echo "  -n          Show line numbers"
    echo "  -v          Show lines that DON'T contain the query"
    echo "  -h,--help   Show this help message"
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
        -h|--help)
            show_help
            exit 0
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
found_match=false
while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == *"$query"* && "$show_invalid_match" == false ]]; then
        if [[ "$show_line_number" == true ]]; then
            echo "$line_number:$line"
        else
            echo "$line"
        fi
        found_match=true
    elif [[ "$line" != *"$query"* && "$show_invalid_match" == true ]]; then
        if [[ "$show_line_number" == true ]]; then
            echo "$line_number:$line"
        else
            echo "$line"
        fi
        found_match=true
    fi
    ((line_number++))
done < "$file"

# Show message if no matches found
if [[ "$found_match" == false ]]; then
    if [[ "$show_invalid_match" == true ]]; then
        echo "No lines without '$query' found in '$file'"
    else
        echo "No lines containing '$query' found in '$file'"
    fi
fi