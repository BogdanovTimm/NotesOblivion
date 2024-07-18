#                  Types of int

Types of ints (from smalles to largest):
- `short int`
- `int`
- `long int`      - To force compiler to treat some value as `long int`: `12345L`
- `long long int` - To force compiler to treat some value as `long long int`: `12345LL`
- from `<stdint.h>`:
    - `size_t`
    - `int32_t`

Also, they may be:
- `singend` - default one
- `unsigned` - to force compiler to treat some value as `unsigned`: `12345U`

You may combine `U` and `L` at the end to force compiler to treat some evalue as `unsigned long long int`: `12345ULL`

#                  Overflow

Overflow is when you add (or multiply) some `int`s and the answer can't fit into `int`'s Max size (it is too large). The answer for `unsigned` and `signed` will vary:
- `signed` - answer is undefined (it is very dangerous)
- `unsigned` - answer = `tooLargeValue % 2^bitsToRepresentInt`. For example, if processor uses 16 bits to represent `int`, the last value is 65535 and we add 1, the answer = 65536 % 2^16, which is equal to 0.