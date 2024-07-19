#                  assert.h

##                  Compile time

- `static_assert()`
- `_Statis_assert` - Macro

##                  Runtime time 

- `assert()` - calls `abort()` if not true
- `NDEBUG()` - Macro. If the `NDEBUG` macro is not defined during compilation, every time execution passes by the call to this macro, the expression is evaluated. In production compilations, use `NDEBUG` to switch off all assert. 