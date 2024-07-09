#                  Array parameter

To enshure that you will get array with at least 1 character, you may use:
```C

```

#                  Structs

Structs passes as a value, so if you change it within a function, outside of a function it will be same:
```C
#include <stdio.h>

struct struct_type {
    int variable1;
};

void function(struct struct_type given) {
    given.variable1 = 5;
    printf("%i\n", given.variable1);
}

int main(void) {
    struct struct_type struct1 = {
        .variable1 = 1,
    };
    function(struct1);
    printf("%i\n", struct1.variable1);
    return 0;
}
```
