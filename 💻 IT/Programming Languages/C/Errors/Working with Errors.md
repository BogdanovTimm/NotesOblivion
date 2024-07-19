the C standard imposes only EOF (which is negative) and EDOM, EILSEQ, and ERANGE, which are positive. Other values may or may not be provided. Therefore, in the initial part of our code, we have a sequence of preprocessor statements that give default values for those that are missing: 

```C
#include <limits.h>
#include <errno.h>

#ifndef EFAULT
#    define EFAULT EDOM
#endif
#ifndef EOVERFLOW
#    define EOVERFLOW (EFAULT-EOF)
#    if EOVERFLOW > INT_MAX
#        error EOVERFLOW constant is too large
#    endif
#endif
#ifndef ENOMEM
#    define ENOMEM (EOVERFLOW+EFAULT-EOF)
#    if ENOMEM > INT_MAX
#        error ENOMEM constant is too large
#    endif
#endif
```

Dynamic runtime errors are a bit more difficult to handle. In particular, some functions in the C library may use the pseudo-variable errno to communicate an error condition. If we want to capture and repair all errors, we have to avoid any change to the global state of the execution, including to errno. This is done by saving the current value on entry to the function and restoring it in case of an error with a call to the small function error_cleanup: 

```C
static inline int throwError(int errorToThrow, int globalErrno) {
    errno = globalErrno;
    return -errorToThrow;
}

void function() {
    int savedGlobalErrno = errno;
    throwError(EOVERFLOW, savedGlobalErrno);
}

void main() {
    function();
}
```

#                  Allocated

If you work with `malloc()`, then, after calling `throwError()`, use `goto` to jump to `free(objectToDelete)`:
```C
void function() {
    if (Error) {
        throwError(EOVERFLOW, savedGlobalErrno);
        goto CLEANUP;
    }
    return whatYouNeedToReturn;
    CLEANUP:
        free(objectToDelete);
        return whatYouNeedToReturn;
}
```