## Q1 : **Custom Command (mygrep.sh)**

You're asked to build a mini version of the grep command. Your script will be called `mygrep.sh` and must support:
**🔹 Basic Functionality**
• Search for a string (case-insensitive)
• Print matching lines from a text file
**🔹 Command-Line Options:**
• `-n` → Show line numbers for each match
• `-v` → Invert the match (print lines that **do not** match)
• Combinations like `-vn`, `-nv` should work the same as using `-v` `-n`
  
**🛠️ Technical Requirements:**
1.  The script **must be executable** and accept input as:
2.  It must **handle** invalid input (e.g., missing file, too few arguments).
3.  Output must **mimic grep's style** as closely as possible.
  
**🧪 Hands-On Validation:** You **must test your script** with the file testfile.txt containing the following:
Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three
✅ Include:
• Screenshot of your terminal running the script with: 
    ◦ ./mygrep.sh hello testfile.txt
    ◦ ./mygrep.sh -n hello testfile.txt
    ◦ ./mygrep.sh -vn hello testfile.txt
    ◦ ./mygrep.sh -v testfile.txt (expect: script should warn about missing search string)
  
**🧠 Reflective Section**
In your submission, include:
1.  A breakdown of **how your script handles arguments and options.**
2.  A short paragraph: **If you were to support regex or -i/-c/-l options, how would your structure change?**
3.  What part of the script was hardest to implement and why?
  
**🏆 Bonus:**
• Add support for `--help` flag to print usage info.
• Improve option parsing using getopts.