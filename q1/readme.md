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
  Before any other processing, the script scans all arguments for a `--help` flag. If found, it immediately prints usage information, offering user guidance without proceeding further.
  
- **`getopts` Parsing**:  
  The script uses `getopts` to handle short options like `-n`, `-v`, or `-h`. This allows flexible option management and robust error handling, while ensuring that options can be combined in any order.

- **Shifting and Assigning Arguments**:  
  After parsing options, the script uses `shift` to move past them, isolating positional arguments. The first remaining argument becomes the **search query**, and the next is the **file** to search in.

- **Critical Validations**:  
  The script validates that:
  - A search query is provided.
  - A valid, readable file is specified.
  - Errors are handled gracefully with clear error messages.

---

## 2. **Supporting Additional Features (Regex, `-i`, `-c`, `-l` options)**

- **Option Expansion**:  
  To support more features, I would expand the `getopts` string (e.g., `getopts ":nvicl"` for new flags) and add conditional logic based on the newly parsed options.

- **Regex Matching**:  
  I would replace the simple string matching with Bash's `[[ $line =~ $pattern ]]` syntax, enabling full regular expression support.

- **Filename-Only Output (`-l`)**:  
  Instead of printing matching lines, if `-l` is set, the script would detect the first match in a file and simply print the filename.

- **Case-Insensitive Search (`-i`)**:  
  With `-i`, matching would need to normalize both the line and search string to lowercase before comparison, or leverage `grep -i` or case-insensitive regex matching.

- **Match Count (`-c`)**:  
  I would introduce a counter variable that increments with every match found, and print the final count instead of matching lines if `-c` is used.

---

## 3. **Hardest Part to Implement**

- **Positional Argument Parsing**:  
  Correctly distinguishing between options and actual arguments (the search string and filename) was the most challenging. Bash doesn't automatically separate them cleanly after options parsing, so a careful manual check was necessary.

- **File Validation**:  
  Ensuring the specified file exists and is readable (and handling all possible permission errors properly) added complexity. Proper checks were vital to prevent runtime errors or misleading output.

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