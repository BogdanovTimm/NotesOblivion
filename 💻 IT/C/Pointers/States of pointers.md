#                  States of pointers

- Null-pointer          `int* address = (void*) 0;` - interesting, that they are evaluate as `false` in `if`s
- Valid pointer         `int* address = 1;`
- Indeterminate pointer `int* address;`