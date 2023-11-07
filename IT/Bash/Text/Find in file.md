# Find Lines containing giving REGEXP

`awk '/Text to find/' fileName.txt`

# Find lines that match Nth word

`awk '$2 == "WordToFind" {print($0)}' fileName.txt` - prints only lines which 2nd word is equal to WordToFind

# Find Nth word in each line

`awk -F":" '{print("2nd word is: ", $2)}' fileName.txt` - prints 2nd word from each line.
where:
- `-F":"` - allows you to choose custom delimiter between words (instead of a standard whitespace)

# Find Nth word from the end in each line

`awk -F":" '{print("2nd word from the end is: ", $(NF-2))}' fileName.txt` - prints 2nd word from each line.
