#                  Do not

- Don’t use `gets()` 
- Find EOF without `feof()` - detecting a return of EOF alone is not sufficient to conclude that the end of the stream has been reached. We have to call feof to test whether a stream’s position has reached its end-of-file marker. End of file can only be detected after a failed read. 

# Unformatted text input. 


- `fgetc()` - for a single character
- `fgets()` - for a string.

```C
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

enum {
    buf_max = 32,
};

int main(int argc, char* argv[argc +1]) {
    int return_code = EXIT_FAILURE;
    char buffer[buf_max] = { 0 };
    for (int i = 1; i < argc; ++i) {              // Processes args
        FILE* current_file = fopen(argv[i], "r"); // as filenames
        if (current_file) {
            while (fgets(buffer, buf_max, current_file)) {
                fputs(buffer, stdout);
            }
            fclose(current_file);
            return_code = EXIT_SUCCESS;
        } else {                                  // Provides some error diagnostic
            fprintf(stderr, "Could not open %s: ", argv[i]);
            perror(0);
            errno = 0;                            // Resets the error code
        }
    }
    return return_code;
}
```