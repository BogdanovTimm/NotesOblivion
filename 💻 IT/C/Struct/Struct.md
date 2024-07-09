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

#                  Comparing structs

Structures can be assigned with `=` but not compared with `==` or `!=`

#                  Inner structs

All struct declarations in a nested declaration have the same scope of visibility. That is, if the previous nested struct declarations appear globally, both struct s are subsequently visible for the whole C file. If they appear inside a function, their visibility is bound to the {} block in which they are found. Because of that, inner structs make no sense