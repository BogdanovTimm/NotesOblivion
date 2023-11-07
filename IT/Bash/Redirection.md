# What it is?

It is when you use the output of some application as an input for other command or to write it into a file.

# Append vs Rewrite

`command1 > fileName.txt` - deletes everything in the file and write output from the command1

`command1 >> fileName.txt` - adds output from file to the end of a file

# Redirect both out and errors into some file

`command1 &>> fileName.txt`