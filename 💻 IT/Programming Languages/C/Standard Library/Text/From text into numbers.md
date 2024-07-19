#                  Do not

- Do not use text as integers

#                  ctype.h

##                  Functions

- `strto[X]X[XX]` - Here the characters at the end of the names correspond to the type: 
    - u    - unsigned  - for 1st [X])
    - l    - long      - for second X
    - d    - double    - for second X
    - f    - float     - for second X
    - imax - intmax_t  - for all 4 X
    - umax - uintmax_t - for all 4 X
For example: `strtoul unsigned long int strtoul(char const nptr[restrict], char** restrict endptr , int base);` - interprets a string `nptr` as a number given in base base. Interesting values for base are 0, 8, 10, and 16. The last three correspond to octal, decimal, and hexadecimal encoding, respectively. The first, 0, is a combination of these three, where the base is chosen according to the usual rules for the interpretation of text as numbers: "7" is decimal, "007" is octal, and "0x7" is hexadecimal. More precisely, the string is interpreted as potentially consisting of four different parts: white space, a sign, the number, and some remaining data.

