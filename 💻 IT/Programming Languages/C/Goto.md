#                  Do not

- Don't use `goto` if it is not necessary. Use it only for exceptions, because objects that were defined inside `LABEL` will live untill the code they are in dies.

#                  Goto

`goto` works only within 1 function.

#                  setjmp.h

- `longjmp(given_jmp_buff)` - `longjmp()` never returns to the caller, because it has `_Noreturn` as return type
- `setjmp(given_jmp_buff)` - When reached through normal control flow, a call to `setjmp()` marks the call location as a jump target and returns 0.

Objects that are modified across `longjmp()` must be volatile. 