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
    exit 0
}

# Main script
query=""
file=""

show_line_number=false
show_invalid_match=false

# Check if --help is in any position of the arguments
for arg in "$@"; do
    if [[ "$arg" == "--help" ]]; then
        show_help
    fi
done

while getopts ":nvh" opt; do
    case "$opt" in
        n)
            if [[ "$show_line_number" == true ]]; then
                error_exit "Repeated option '-n'"
            fi
            show_line_number=true
            ;;
        v)
            if [[ "$show_invalid_match" == true ]]; then
                error_exit "Repeated option '-v'"
            fi
            show_invalid_match=true
            ;;
        h)
            show_help
            ;;
        \?)
            error_exit "Invalid option: -$OPTARG"
            ;;
    esac
done

# Shift off processed options
shift $((OPTIND - 1))

# Loop to set query and file based on arguments
for arg in "$@"; do
    if [[ -z "$query" && ! -e "$arg" ]]; then
        query="$arg"
    elif [[ -z "$file" && -e "$arg" ]]; then
        file="$arg"
    else
        error_exit "Unexpected argument '$arg'"
    fi
done

# Final validations
[[ -z "$query" ]] && error_exit "Missing search query"
[[ -z "$file" ]] && error_exit "Missing file"
[[ ! -r "$file" ]] && error_exit "No read permission for '$file'"

# Execute grep
# Read the file line by line
line_number=1
found_match=false
query_lower="${query,,}"
while IFS= read -r line || [[ -n "$line" ]]; do
    line_lower="${line,,}"

    if [[ "$line_lower" == *"$query_lower"* && "$show_invalid_match" == false ]]; then
        # Matching line
        if [[ "$show_line_number" == true ]]; then
            echo "$line_number:$line"
        else
            echo "$line"
        fi
        found_match=true
    elif [[ "$line_lower" != *"$query_lower"* && "$show_invalid_match" == true ]]; then
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