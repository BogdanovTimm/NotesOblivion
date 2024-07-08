#                  Non-null pointer

If you want to restrict that only non-null pointer may be passed as a parameter to a function, you may use. If null pointer will be passed, program will crash:
```C
void function(int given[0]) {
    (* given) = 2;
}
```