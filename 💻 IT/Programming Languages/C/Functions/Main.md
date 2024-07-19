Use `EXIT_SUCCESS` and `EXIT_FAILURE` as return values for main
Reaching the end of main is equivalent to a return with value `EXIT_SUCCESS`

All command-line arguments are transferred as `strings` (with 0 at the end).
At the end of command-line arguments array is just 0 named `argc`.