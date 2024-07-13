#                  What it does

It forces to use variable from the filescope (out of all functions).

```C
#include <stdio.h>

unsigned int variable = 1; // File-scope variable

int main(void) {
    unsigned int variable = 99; // Function-scope variable
    if (variable) {
        extern unsigned int variable; // Forces to use File-scope variable
        printf("%u\n", variable); // Prints: 1
    } else {
        printf("%u\n", variable);
    }
}
```