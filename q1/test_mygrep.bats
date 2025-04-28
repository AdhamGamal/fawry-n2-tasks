#!/usr/bin/env bats

# Test case 1: Basic search for query "test"
@test "Basic search for query 'test'" {
    run bash ./mygrep.sh "test" testfile.txt
    [ "$status" -eq 0 ]
    [ "${lines[0]}" == "This is a test" ]
    [ "${lines[1]}" == "another test line" ]
}

# Test case 2: Search for query "test" with -n option (line numbers)
@test "Search for query 'test' with -n option" {
    run bash ./mygrep.sh -n "test" testfile.txt
    [ "$status" -eq 0 ]
    [ "${lines[0]}" == "2:This is a test" ]
    [ "${lines[1]}" == "3:another test line" ]
}

# Test case 3: Search for query "test" with -v option (lines that do not contain the query)
@test "Search for query 'test' with -v option" {
    run bash ./mygrep.sh -v "test" testfile.txt
    [ "$status" -eq 0 ]
    [ "${lines[0]}" == "Hello world" ]
    [ "${lines[1]}" == "HELLO AGAIN" ]
    [ "${lines[2]}" == "Don't match this line" ]
}

# Test case 4: Help option -h
@test "Help option -h" {
    run bash ./mygrep.sh -h
    [ "$status" -eq 0 ]
    [[ "${output}" =~ "Usage: ./mygrep.sh" ]]
    [[ "${output}" =~ "Options:" ]]
}

# Test case 5: Query is empty
@test "Query is empty" {
    run bash ./mygrep.sh "" testfile.txt
    [ "$status" -ne 0 ]
    [[ "${output}" =~ "Missing search query" ]]
}

# Test case 6: File is empty
@test "File is empty" {
    echo "" > testfile2.txt
    run bash ./mygrep.sh "test" testfile2.txt
    [ "$status" -eq 0 ]
    [[ "${output}" == "No lines containing 'test' found in 'testfile2.txt'" ]]
    run rm -f testfile2.txt
}

# Test case 7: Invalid option passed
@test "Invalid option passed" {
    run bash ./mygrep.sh -x "test" testfile.txt
    [ "$status" -ne 0 ]
    [[ "${output}" =~ "Invalid option: -x" ]]
}

# Test case 8: No matching lines for query
@test "No matching lines for query" {
    run bash ./mygrep.sh "notfound" testfile.txt
    [ "$status" -eq 0 ]
    [[ "${output}" == "No lines containing 'notfound' found in 'testfile.txt'" ]]
}

# Test case 9: Query with case insensitivity (HELLO)
@test "Query with case insensitivity" {
    run bash ./mygrep.sh "hello" testfile.txt
    [ "$status" -eq 0 ]
    [ "${lines[0]}" == "Hello world" ]
    [ "${lines[1]}" == "HELLO AGAIN" ]
}

# Test case 10: Query with case insensitivity and -v option (lines without query)
@test "Query with case insensitivity and -v option" {
    run bash ./mygrep.sh -v "hello" testfile.txt
    [ "$status" -eq 0 ]
    [ "${lines[0]}" == "This is a test" ]
    [ "${lines[1]}" == "another test line" ]
    [ "${lines[2]}" == "Don't match this line" ]
    [ "${lines[3]}" == "Testing one two three" ]
}

# Test case 11: Repeated -n option should throw an error
@test "Repeated -n option should throw an error" {
    run bash ./mygrep.sh -n -n "test" testfile.txt
    [ "$status" -ne 0 ]
    [[ "${output}" =~ "Repeated option '-n'" ]]
}

# Test case 12: Repeated -v option should throw an error
@test "Repeated -v option should throw an error" {
    run bash ./mygrep.sh -v -v "test" testfile.txt
    [ "$status" -ne 0 ]
    [[ "${output}" =~ "Repeated option '-v'" ]]
}