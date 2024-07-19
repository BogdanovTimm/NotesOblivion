#                  string.h

##                 Functions

- `strspn()`  - one of the string search functions provided by `string.h`. This function returns the length of the initial sequence in the first parameter that entirely consists of any character from the second parameter
- `strcspn()` - looks for an initial sequence of characters NOT present in the second argument
- `memchr()`  - is not const-safe. May be used to check if given char array is actually string
- `strchr()`  - is not const-safe