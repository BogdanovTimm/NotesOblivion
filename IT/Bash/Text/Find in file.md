# Find Lines containing giving REGEXP

```bash
awk '/^REGEXP to find/ {print$0}' fileName.txt
```
where:
- `-F":"` - allows you to choose custom delimiter between words (instead of a standard whitespace)

# Find Lines that match Nth Word

Prints only lines which 2nd word is equal to given regexp:

```bash
awk '$2 == "^RegexpToFind" {print($0)}' fileName.txt
``` 

# Find Nth Word in each Line

Prints 2nd word from each line:

```bash
awk '{print("2nd word is: ", $2)}' fileName.txt
```

# Find Nth Word from the End in each Line

Prints 2nd word from each line.:

```bash
awk '{print("2nd word from the end is: ", $(NF-2))}' fileName.txt
```

# Custom dilimeter

Use ':'  as a dilimeter instead of a standard whitespace:

```bash
awk -F": '/text/ {print($0)}' fileName.txt
```


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

Just replace `'` with `\47`:

```bash
awk '/Your/47s/ {print($0)}' fileName.txt
```
