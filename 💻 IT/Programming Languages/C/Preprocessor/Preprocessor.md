In preprocessor conditions, unknown identifiers evaluate to 0. 

#                  Variables

Always use `()` if you need to do some computations:
```C
#define VARIABLE_NAME_1 228
#define VARIABLE_NAME_2 (228 / 2) 
```

#                  Macro-functions

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
#define NEW_MACRO(GIVEN_TYPE, ...) \
#       GIVEN_TYPE ## _init(malloc(sizeof(GIVEN_TYPE)), __VA_ARGS__)// Here T will be replaced by given.
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
    #define MACRO_FUNCTION(S) MACRO_FUNCTION("" S "")
    ```