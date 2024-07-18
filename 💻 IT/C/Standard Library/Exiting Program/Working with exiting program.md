#                  Do not

Don’t use functions other than `exit()` for program termination, unless you have to inhibit the execution of library cleanups. 

#                  stdlib.h

- `exit(statusToReturmToOS)`
- `atexit(void func(void))` - this is the ideal place to put all kinds of cleanup code, such as freeing memory or writing a termination timestamp to a log file
- `quick_exit(status_as_int)` - allows you to exit and don't call `atexit()`. But it will call `at_quick_exit()`
- `at_quick_exit(void func(void))`
- `_Exit(status_as_int)` - allows you to exit and don't call both `atexit()` and `at_quick_exit()`. The only things that are executed are the platform-specific cleanups, such as file closure.
- `abort(void)` - allows you to exit and don't call both `atexit()` and `at_quick_exit()`. Even most of platform-specific cleanups will not be called.

##                  EXIT_SUCCESS

stdlib.h:
- Instead of 0, for success you need to use `EXIT_SUCCESS`
- Instead of 1, for failure you need to use `EXIT_FAILURE`