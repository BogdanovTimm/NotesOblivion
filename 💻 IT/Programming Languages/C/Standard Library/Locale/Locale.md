#                  locale.h

`setlocale(to_which_to_apply, locale_as_array_of_char_const)` - 
    - to_which_to_applay may be:
        - "LC_COLLATE" - String comparison through strcoll and strxfrm
        - "LC_CTYPE"    - Character classification and handling functions
        - "LC_MONETARY" - Monetary formatting information, `localeconv()`
        - "LC_NUMERIC"  - Decimal-point character for formatted I/O, `localeconv()`
        - "LC_TIME"     - `strftime()`
        - "LC_ALL"      - All of the above 

Available locales:
- C
- "" - default in OS