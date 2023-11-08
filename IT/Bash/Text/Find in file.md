# Find Lines containing giving REGEXP

`awk '/^REGEXP to find/' fileName.txt`
where:
- `-F":"` - allows you to choose custom delimiter between words (instead of a standard whitespace)

# Find Lines that match Nth Word

`awk '$2 == "^RegexpToFind" {print($0)}' fileName.txt` - prints only lines which 2nd word is equal to given regexp

# Find Nth Word in each Line

`awk '{print("2nd word is: ", $2)}' fileName.txt` - prints 2nd word from each line.


# Find Nth Word from the End in each Line

`awk '{print("2nd word from the end is: ", $(NF-2))}' fileName.txt` - prints 2nd word from each line.

# Custom dilimeter

`awk -F": '/text/ fileName.txt'` - use ':'  as a dilimeter instead of a standard whitespace

# Functions

Built-in function:
- `toupper($0)` - to upper case
- `tolower($0)` - to lower case
- `length($0)` - length
- `substr($0, 0, 5)` - substring(text, startIndex, length)
- `system("echo Hellow")` - calls command in terminal

# Variables

Built-in variables:
- `$0` - current line
- `$1` - current 1st word
- `NF` - current last word position (starting from 1)
- `FNR` - current line number position that sets to 0 when goes to another file (starting from 1)
- `NR` - current line number that doesn't sets to 0 when goes to another file (starting from 1)

Also, you can use variables with `$`: `$NF` - will give you `$4` for example.

# How to escape `'`

`awk '/Your/47s/ {print($0)}' fileName.txt` - just replace `'` with `\47`