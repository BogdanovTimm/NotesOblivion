#                  Running a program

We can see what a program does using `strace`. Let's see what `cat` does using:
```Shell
strace \
    cat ./foo
```

The output will be the C-code:
```C
open("foo",               // Opens [./foo] for reading. 
     O_RDONLY|O_LARGEFILE // Opens a file Read-Only
) = 3                     // [3] if the File-Descriptor
read(3,         // Read a file with File-Descriptor = 3, 
     "hello\n", // Buffer where the result of the read will be placed
     4096       // Size of the buffer (4KB)
) = 6           // Number of bytes returned
write(1,         // Writes to the file with File-Descriptor = 1 (Standerd-Input)
      "hello\n", // What to write
      6          // Number of byte to write
) = 6
// Here it prints [hello]
read(3,   // Reads a file with File-Descriptor = 3
     "",  // Result of reading
     4096 // Size of the buffer (4KB)
) = 0     // Nothing was read
close(3) // Stop working with file with File-Descriptor = 3
```

Why `open()` returns 3 instead of a 0? - because at the start of the program, it opens 3 files already:
* Standard Input
* Standard Output
* Standard Error