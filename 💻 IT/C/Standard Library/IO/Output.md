#                  Do not

- Text lines should not contain trailing white space. 


#                  Input



#                  Output

There are three other principal interfaces to handle streams: 
- `fopen()`
- `freopen()`
- `fclose()` - If we close the stream with fclose, all buffers are guaranteed to be flushedC to where it is supposed to go. 
- `fflush()` - The function fflush is needed in places where we want to see output immediately on the terminal, or where don’t want to close the file yet but want to ensure that all content we have written has properly reached its destination.
-  `puts`  -         append end-of-line character to the string
- `fputs` - doesn’t append end-of-line character to the string

```C
int main(int argc, char* argv[argc +1]) { 
    FILE* file = fopen("file_name.txt", "a"); 
    if (! file) {
        perror("Failed"); 
        return 1;
    } 
    fputs("Lorem Ipsum\n", file); 
    return 0; 
}
```

Modes for `fopen()`:
- "a" - safe file content, add new to the end of a file. Creates an empty text file if necessary.
- "w" - delete file content, add new. Creates an empty text file if necessary.
- "r" - read-only, position at the start of the file
- "+" - read + write
- "b" - open as a binary
- "x" - creates if not exist
- Combinations:
    - "a+" - open for reading and writing at end-of-file. Creates an empty text file if necessary; 
    - "w+" - open for reading and writing. Creates an empty text file or wipes out content;
    - "r+" - Opens an existing text file for reading and writing at beginning of file
    - "ab" "rb" "wb" "a+b" "ab+" "r+b" "rb+" "w+b" "wb+" - Same as above, but for a binary file instead of a text file 
    - "wx" "w+x" "wbx" "w+bx" "wb+x" - Same as above, but error if the file exists prior to the call 

If we know that the numbers we write will be read back in from a file later, the forms "%+d" for signed types, "%#X" for unsigned types, and "%a" for floating point are the most appropriate. They guarantee that the string-to-number conversions will detect the correct form and that the storage in a file will not lose information. 