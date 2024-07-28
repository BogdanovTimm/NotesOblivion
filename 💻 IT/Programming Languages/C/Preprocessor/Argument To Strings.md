#                  What it is

`# given` will turn given arguments into a string.

```C
#include <stdio.h>

#define MACRO_FUNCTION(given) do { \
    printf(# given                 \
           " = %d\n",              \
           given                   \
    );                             \
} while (0)

void main() {
    unsigned int variable1 = 2;
    unsigned int variable2 = 8;
    MACRO_FUNCTION(variable2/variable1); // Will print: variable2/variabl1 = 4
}
```