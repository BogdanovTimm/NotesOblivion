#                  Do not

- Don’t cast the return of `malloc()` and other functions. 
- Don't forget in `#include <stdlib.h>`

In fact, this mechanism creates storage instances that are only seen as byte arrays and do not have any interpretation as objects. They only acquire a type, once we store something. 

#              stdlib.h

- `void* malloc(size_to_allocate_in_bytes)`:
    - `double* address_of_variable = malloc(length * sizeof(*(variable)))` - simple variable
    - `double* address_of_array    = malloc(sizeof(double[length]))` - array
- `void free(void* ptr)`
- `void* calloc(size_t nmemb , size_t size)` - like `malloc()`, but also sets all bits to 0
- `void* realloc(void* ptr , size_t size)` - change size of allocated memory
- `void* aligned_alloc(size_t alignment , size_t size)` - `malloc()` using non-default alignment