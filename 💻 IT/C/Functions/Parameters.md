#                  Always do

- Functions that receive pointers should use array syntax and distinguish different cases: 
    - A pointer to a single object of the type – These functions should use the `givenArray[static 1]` notation and thus indicate that they expect a pointer that is nonnull: `void function(double givenArray[static 1])`
    - A pointer to a collection of objects of known number – These functions should use the `givenArray[static 228]` notation and thus indicate that they expect a pointer that points to at least that number of elements: `void function(double givenArray[static 228])`; 
    - A pointer to a collection of objects of unknown number – These functions should use the VLA notation: `void function(size_t arraySize, double givenArray[arraySize])`
    - A pointer to a single object of the type or a null pointer – Such a function must guarantee that even when it receives a null pointer, the execution remains in a defined state: `void function(double* givenObjectOrNullAddress)`

#                  Arrays vs pointers

- use array   notation if we suppose it can’t be `null`
- use pointer notation if it corresponds to a single item of the base type that also can be `null`

#                  Unnnamed Array aka Compound Literal

`function((unsigned int[]) {1, someVariable});`

Also, it may be const:
`function((const unsigned int[]) {1, someVariable});`


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

Structs in Heap:
```C
#include <stdio.h> 

typedef struct struct_name struct_name;

struct struct_name {
    int  struct_variable1;
    int* struct_array;
};

void circular_init(struct_name* address_of_given, size_t size) {
    if (address_of_given) {
        if (size) {
            *(address_of_given) = (struct_name) {
                .struct_variable1 = size, 
                .struct_array     = malloc(sizeof(int[size])), 
            };
        }
    }
}

int main(void) {
    // main function....
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

#                  Restrict

`restrict` means that object, which address function receives, has only 1 pointer to that address:
```C
void function(int* restrict oneAndOnlyAddress) {

}
```

#                  const

Using `const` only restricts modifying given withing funciton. Oustide, it may be changed.
```C
void function(unsigned int const given) {
}
```

#                  ...

`void function(...) {}` is a bad way to create variable length list of parameters.
Better use Macro-technics from Modern C (which I didn't get).

#                  Generics

Constraints:
- The type expressions in a `_Generic()` expression should only be unqualified types: 
    - no array types
    - no function types
    - no pointer to VLA

Code:
```C
inline void functionWithGeneric(unsigned int given1, unsigned int given2) {
    // Very good function body for unsigned ints
}
inline void functionForFLoat(float given1, float given2) {
    // Very goof funciton body for floats
}

#define functionWithGeneric(given1, given2)  \
    _Generic ((given1) + (given2),           \
        float       : functionForFloat      ,\
        unsigned int: functionForUnsignedInt,\
        default     : functionWithGeneric    \
    )                                        \
    ((given1), (given2))
```

#                  Check that given argument is string

It is ugly, but it is the only way to do it:
```C
#ifdef NDEBUG
#    define TRACE_ON 0
#else
#    define TRACE_ON 1
#endif
#define TRACE_PRINT2(F, X)                  \
    do {                                    \
        if (TRACE_ON)                       \
            fprintf(stderr , "" F "\n", X); \
    } while (false)
#define function_to_check(stringParameter) \
    function_to_check("" stringParameter "")

inline char const* (function_to_check)(char const givenString[static 1]){ 
```

#                  Check that given argument is a pointer

```C
#ifdef NDEBUG
#    define TRACE_ON 0
#else
#    define TRACE_ON 1
#endif 
#define TRACE_PRINT2(F, X)                  \
    do {                                    \
        if (TRACE_ON)                       \
            fprintf(stderr , "" F "\n", X); \
    } while (false)
#define CHECK_IF_POINTER(HEAD , MAYBE_POINTER)      \
    TRACE_PRINT2(HEAD " %p", ((void*){ 0 } = (MAYBE_POINTER)))
```