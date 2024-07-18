#                  Do not

- Text lines should not contain trailing white space. 

#                  Print to terminal

- floats:
    - `printf("Text to display [%5.2f]\n", givenFLoat)` - `%<Minimum-width>.<Max Numbers after dot>f`. If `<Minimum-width>` < 0, then it will be left-justified.
    - `printf("Text to display [%5.2e]\n", givenFLoat)` - exponential form. `%<Minimum-width>.<Max Numbers after dot>f`. If `<Minimum-width>` < 0, then it will be left-justified.
    - `printf("Text to display [%5.2g]\n", givenFLoat)` - automatically chooses `%f` or `%e`. `%<Minimum-width>.<Max Numbers after dot>f`. If `<Minimum-width>` < 0, then it will be left-justified.
- integers: `printf("Text to display: [%8.4d]\n", givenInteger);` - `%<Minimum-width-padded-with-spaces>.<Minimum-width padded with 000>d`. If `<Minimum-width-padded-with-spaces>` < 0, then it will be left-justified.
- chars:
    - `putchar(givenChar)` - faster than `printf()`
    - `printf("%c", givenChar)`

#                Print pointers

```C
printf("%p", (void*) given_address);
```