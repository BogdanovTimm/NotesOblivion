In preprocessor conditions, unknown identifiers evaluate to 0.

#                  Do not

- Do not think that marco-variable  or macro-function within function will be visible only inside that function. Every macro-variable and macro-function that will be visible

#                  Variables

Always use `()`
```C
#define VARIABLE_NAME_1 (228)
#define VARIABLE_NAME_2 (228 / 2) 
```








#                  Macro-functions

Example of a dummuy macro-function:
```C
#include <stdio.h>

#define MACRO_FUNCTION(given) do {    \
    printf("Lorem Ipsum\n");          \
    printf("Given: [%u]\n", (given)); \
} while (0)

void main() {
    MACRO_FUNCTION(228);
}
```

From:
```C
someType* someType_new(long long numesomeTypeor , unsigned long long denominator) {
    return someType_init(malloc(sizeof(someType)), numesomeTypeor,  denominator);
}
int main() {
    someType const* mysomeType = someType_new (13, 7);
}
```

To:
```C
#define NEW_MACRO(GIVEN_TYPE, ...) (\
        GIVEN_TYPE##_init(malloc(sizeof(GIVEN_TYPE)), __VA_ARGS__)// Here T will be replaced by given.  \
)
                                                                                               // 'T ## _init' means that they will be concatenated
                                                                                               // '...' may be used as '__VA_ARGS__'
int main() {
    //              Code below = someType_init(someType, 13, 7)
    someType const* mysomeType = NEW_MACRO(someType, 13, 7);
}
```









#                  Function that will not be replaced by macro


```C
void (function_name)() { // This funciton will not be replaced by macro

}
```









# Rule

- If a functional macro is not followed by `()`, it is not expanded:
    ```C
    #define MACRO_FUNCTION(S) \
        MACRO_FUNCTION("" S "")
    ```