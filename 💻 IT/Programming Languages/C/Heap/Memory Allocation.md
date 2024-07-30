#                  Do not

- Don not cast the return of `malloc()` and other functions. 
- Don not forget in `#include <stdlib.h>`
- Don not use `malloc()`. Dynamical allocation should be done with `calloc()`. This avoids another quarter of the problems with uninitialized objects. 
- Do not pass something other than pointer as an argument to a `free()`
- Do not use pointer that was previously passed as an argument to a `free()`

In fact, this mechanism creates storage instances that are only seen as byte arrays and do not have any interpretation as objects. They only acquire a type, once we store something. 









#              stdlib.h

- Creatin objects in Heap:
    -  2 uses for `malloc(numberOfBytes)`:
        - `double* address_of_variable = malloc(length * sizeof(*(variable)))` - simple variable
        - `double* address_of_array    = malloc(sizeof(double[length]))`       - array
    - `calloc(numberOfObject, sizeOfSingleObject)` - like `malloc()`, but also sets all bits to 0
    - `aligned_alloc(size_t alignment , size_t size)` - `malloc()` using non-default alignment
- Changing size of objects in Heap:
    - `void* realloc(startOfHeapArea, newSize)` - changes size of allocated memory. It does not initialize new bytes if it enlarge given Heap area. If `startOfHeapArea` = 0, then it behaves like `malloc()`. If `newSize()` = 0 it behaves like `free()`. `realloc()` may movw given Heap area to a new RAM addresses, so be shure to refresh all references to a given Heap Area after success `realloc()`. If it falls - nothing changs.
- Deleting objects in Heap:
    - `void  free(startOfHeapAread)`









#                  Null pointer

`malloc()` and `calloc()` will give you pointer to a `NULL`. It means that there is not anough memory in the Heap. Because `NULL` is treated same as 0 in `if()` you may test it like:
```C
unsigned int* integerInHeap = malloc(sizaeof(int));
if (integerInHeap) {
    // Do something if there is not enough memory in the Heap
}
```