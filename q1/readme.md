# Custom Command: **`mygrep.sh`**

## 📝 Task Description

You are asked to build a mini version of the `grep` command. Your script will be called **`mygrep.sh`** and must support:

### 🔹 Basic Functionality:
- Search for a string (case-insensitive)
- Print matching lines from a text file

### 🔹 Command-Line Options:
- `-n` → Show line numbers for each match
- `-v` → Invert the match (print lines that **do not** match)
- Combinations like `-vn`, `-nv` should work the same as using `-v` and `-n` separately.

---

## 🛠️ Technical Requirements:
1. The script **must be executable** and accept inputs.
2. It must **handle invalid input** (e.g., missing file, too few arguments).
3. Output must **mimic `grep` style** as closely as possible.

---

## 🧪 Hands-On Validation:

You must test your script with a file named `testfile.txt` containing the following lines:

```
Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three
```

✅ Include screenshots for:

- `./mygrep.sh hello testfile.txt`
- `./mygrep.sh -n hello testfile.txt`
- `./mygrep.sh -vn hello testfile.txt`
- `./mygrep.sh -v testfile.txt` (expect: script should warn about missing search string)

---

## 📸 Screenshots:

- **Test Cases Screenshot**  
    ![Test Cases Screenshot](images/Test%20cases%20Screenshot.png)

- **Unit Test Screenshot**  
    ![Unit Test Screenshot](images/Unit%20test%20Screenshot.png)

---

# 📚 Reflective Section

Below are my detailed reflections and answers based on the work:

---

## 1. **Argument and Option Handling Breakdown**

- **Manual `--help` Check**:  
  Before any other processing, the script scans through all arguments to check if the `--help` option is present, providing early assistance for the user if requested.
  
- **`getopts` Parsing**:  
  The script then uses `getopts` to handle short options such as `-n`, `-v`, `-h`, allowing for simple and clear error handling for invalid options and managing duplicates.

- **Shifting and Assigning Arguments**:  
  Once options are processed, the script shifts the arguments (removes the parsed ones) to access remaining positional arguments. The first argument that isn't a valid option or flag is assigned as the search query, and the first valid file is assigned as the file to search in.

- **Critical Validations**:  
  Finally, the script ensures that all required inputs are valid:
  - The query must not be missing.
  - The specified file must exist and be accessible with the necessary permissions.
  - Errors are handled gracefully with clear error messages.

---

## 2. **Supporting Additional Features (Regex, `-i`, `-c`, `-l` options)**

- **Expanding Option Parsing**:  
  To add more features like case-insensitive search (`-i`), match count (`-c`), or filename-only output (`-l`), the `getopts` string would be expanded to include these new options. Each option would require associated logic in the script to handle the behavior it represents.

- **Regex Support**:  
  For regular expression matching, the script would use Bash's `=~` operator instead of simple wildcard matching. This allows for more advanced and flexible pattern matching.

- **Filename-Only Output (`-l`)**:  
  If the `-l` flag is set, the script should store filenames in an array and iterate over them, checking each for matches. Once a match is found in a file, the script should display the filename and stop further unnecessary processing for that file to save time and resources.

- **Case-Insensitive Search (`-i`)**:  
  When the `-i` flag is enabled, the script should stop converting variables to lowercase and instead rely on the system's case-insensitive matching.

---

## 3. **Hardest Part to Implement**

- **Positional Argument Parsing**:  
  The most difficult aspect was accurately determining which argument was the query and which was the file. Since there may be multiple arguments, correctly distinguishing between them required careful validation and logic to handle various edge cases, such as missing queries or ambiguous arguments.

- **File Validation**:  
  Ensuring that the file exists and is readable (with proper permissions) was essential for preventing errors when searching through files.

---

# 🏆 Bonus Features Implemented

- **`--help` Flag**:  
  The script supports a `--help` flag to display a clear, structured help message.

- **Advanced Option Parsing (`getopts`)**:  
  Instead of manual parsing, `getopts` was used for robust and scalable option management.

---

# ✅ Conclusion

This project strengthened my Bash scripting skills, especially around:
- Argument parsing and validation
- Mimicking command-line tool behavior
- Building extensible and maintainable scripts

It also showed me how important clear, defensive programming is — especially for user-facing CLI tools.