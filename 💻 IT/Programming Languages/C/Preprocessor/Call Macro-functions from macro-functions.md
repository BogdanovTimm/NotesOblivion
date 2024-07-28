```C
#include <stdio.h>




#define PRINT_GIVEN(givenType, given) do { \
    PRINT_##givenType((given));            \
} while (0)

#define PRINT_UNSIGNED_INT(given) do { \
    printf("Given: [%u]\n", (given));  \
} while (0)

#define PRINT_FLOAT(given) do {        \
    printf("Given: [%f]\n", (given));  \
} while (0)





void main() {
    PRINT_GIVEN(UNSIGNED_INT, 5  ); // Will call PRINT_UNSIGNED_INT(5)
    PRINT_GIVEN(FLOAT       , 5.0); // Will call PRINT_FLOAT(5.0)
}
```