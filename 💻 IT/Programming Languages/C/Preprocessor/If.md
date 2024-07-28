```C
# include <stdio.h>

# define MACRO_VARIABLE (1)

void main() {
    # if MACRO_VARIABLE // Checks whether MACRO_VARIABLE != 0
    printf("Debug: ON");
    # endif
}
```








#                  Check whether Macro-variable exists

```C
# include <stdio.h>

# define MACRO_VARIABLE (1)

void main() {
    # if defined(MACRO_VARIABLE)    // Checks whether MACRO_VARIABLE exists
        printf("Debug: ON");
    # elif !defined(MACRO_VARIABLE) // Checks whether MACRO_VARIABLE not exists
        print("Debug: OFF");
    # else
        print("Actually, this will never be executed");
    # endif
}
```

Code Below is same as code above:
```C
```C
# include <stdio.h>

# define MACRO_VARIABLE (1)

void main() {
    # ifdef MACRO_VARIABLE // Checks whether MACRO_VARIABLE exists
    printf("Debug: ON");
    # endif
}
```
```