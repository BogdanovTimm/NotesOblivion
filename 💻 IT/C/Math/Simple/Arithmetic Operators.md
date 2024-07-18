#                  Do not

- Do not use `signed` and `unsigned` types in the same operation: when `unsigned` type is used in one operation with a `signed` type, `signed` one will be converted into the `unsigned` one. And this will lead to a wrong output (thought it will compile).
- Do not think that when you do a math with 2 numbers they will give you a right answer - they may overflow!. Even if overflowed value may be stored in a larger type, you need to do it yourself: `long int = (long int) INTMAX + 1`. WIthout the typecast this will produce wrong result.

#                  /

##                 Do not

- Do not rely on `/` to produce values that has something after a dot if both numbers are `int`s. For example, `1 / 2` will produce 0. Type cast one of them to `float` to get the right answer
- Do not divide by zero: `5 / 0` will produce undefined result

#                  %

##                 Do not

- Do not rely on it if even one of 2 numbers are minus signed. Read about it more
- Do not use it for floats (you can't. hahaha).

###                % for floats

`fmod()`

#                  Power

`pow()`

#                  Type Conversion 

