#                  Arrays vs pointers

- use array   notation if we suppose it can’t be `null`
- use pointer notation if it corresponds to a single item of the base type that also can be `null`

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

#                  Passing arrays as pointers

If you pass array as a pointer, you must pass array length as another parameter to the function, because `sizeof()` don't work with pointer.

```C
void function(size_t array_size, int const array[array_size]);
```

#                  Passing pointers as arguments

#                  Passing functions as parameters

These 2 variant are same:
```C
void function2(void given_function(void));

typedef void function_type(void);
void function2(function_type* given_function);
```