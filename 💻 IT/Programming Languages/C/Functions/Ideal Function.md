```C
#include <stdio.h>
#include <malloc.h>
#include <errno.h>

static inline int throwError(int errorToThrow, int globalErrno) {
    errno = globalErrno;
    return -errorToThrow;
}

void function(//int* singleMaybeNullObject,
              //int  singleNonNullObject[1],
              //int  arrayOfCompileKnownSize[228],
              //size_t arraySize, int arrayOfRuntimeKnownSize[arraySize]
              ) {
    int savedGlobalErrno = errno;
    register int variable1; // Always use register so you can't access RAM address after function call
    register int variable2;
    printf("Hello\n");
    variable1 = 5; // Initialize variables as close to their use as possible
    variable2 = 228; // Always initialize all local-variables
    register int* heapVariable1 = calloc(1, sizeof(int)); // Use calloc() instead of malloc()
    *(heapVariable1) = 4;
    printf("%i\n", 4);
    for (register unsigned int iterator = 0;
         iterator <= 5;
         iterator++
    )       {
        if (++iterator > UINT_MAX) { // Always check iterator for type-overflow
            throwError(EOVERFLOW, savedGlobalErrno);
        }
    }
}

void main() {
    function();
}```