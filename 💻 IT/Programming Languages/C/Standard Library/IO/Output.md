#                  Do not

- Text lines should not contain trailing white space. 









#                  Print to terminal

- floats/doubles/long doubles:
    - `%5.2f` - `%<Minimum-width>.<Max Numbers after dot>f`. If `<Minimum-width>` < 0, then it will be left-justified.
    - `%5.2e` - exponential form. `%<Minimum-width>.<Max Numbers after dot>f`. If `<Minimum-width>` < 0, then it will be left-justified.
    - `%5.2g` - automatically chooses `%f` or `%e`. `%<Minimum-width>.<Max Numbers after dot>f`. If `<Minimum-width>` < 0, then it will be left-justified.
- integers: `%8.4d` - `%<Minimum-width-padded-with-spaces>.<Minimum-width padded with 000>d`. If `<Minimum-width-padded-with-spaces>` < 0, then it will be left-justified.
- chars:
    - `putchar(givenChar)` - faster than `printf()`
    - `printf("%c", givenChar)`
- RAM addresses:
    - `printf("%p", (void*) given_address);`