#                  Signed vs unsigned char

Because `char`s are stored as `int`s, they may be both `signed` or `unsigned`.
You even may do a math on them.
But, you can't know whether your `char`s are `signed` or `unsigned` by default. So, if you need to treat them like `unsigned` or `signed`, use `signed char` or `unsigned char`










#                  Escaped chars

You may write a char representing it as in 8th base or in 16th base:
- `\33`  - 8th
- `\x1B` - 16th