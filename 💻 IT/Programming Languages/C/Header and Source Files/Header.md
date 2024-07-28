#                  Do not

- Do not define variables like `int variable;`! Define them like `extern int variable;`
- Do not write header-files that do not protected from multiple includions. You may do it like that:
    ```C
    # if !defined(HEADERNAME_H)
    #     define  HEADERNAME_H

    // Header file code

    # endif
    ```









#                  What it is?

Header file is like an Interface in Java - it contains headers of functions and shared variables.