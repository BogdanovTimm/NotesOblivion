#                  Do not

- Text lines should not contain trailing white space. 









#                  Print to terminal

- floats/doubles/long doubles:
    - `%5.2f` - `%<Min-width>.<Max Numbers after dot>f`. If `<Minimum-width>` < 0, then it will be left-justified.
    - `%5.2e` - exponential form. `%<Min-width>.<Max Numbers after dot>f`. If `<Minimum-width>` < 0, then it will be left-justified.
    - `%5.2g` - automatically chooses `%f` or `%e`. `%<Min-width>.<Max Numbers after dot>f`. If `<Min-width>` < 0, then it will be left-justified.
- integers: `%8.4d` - `%<Min-width-padded-with-spaces>.<Min-width padded with 000>d`. If `<Min-width-padded-with-spaces>` < 0, then it will be left-justified.
- chars:
    - `putchar(givenChar)` - faster than `printf()`
    - `printf("%c", givenChar)`
- RAM addresses:
    - `printf("%p", (void*) given_address);`
- Strings:
    - `printf("%.6s", givenString)` - `%<Min-width>.<Max-width>s`. If `<Min-width>` < 0, then it will be left-justified.
    - `puts(givenString)`