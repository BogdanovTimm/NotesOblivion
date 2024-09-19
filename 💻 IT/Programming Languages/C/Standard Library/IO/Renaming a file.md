#                  Code

```C
int tempFile = open("original.txt.tmp", O_WRONLY|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
write(tempFile, buffer, size); // Write old file + new lines to a temp file
fsync(tempFile); // Force to write a file right now
close(tempFile); // Stop working with temporary file
rename("original.txt.tmp", // 1) Rename temporary file into the original one  }
       "original.txt"      // 2) Swaps the new file into place                } So, an atomic update is achieved
);                         // 3) Concurrently deletes old version of the file }
```