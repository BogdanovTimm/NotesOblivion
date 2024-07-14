# What it is

If, by coincidence, the code of the caller (say, fcaller) and the callee (say, fsmall) are present inside the same translation unit (TU), a good compiler may avoid these downsides by inlining. Here, the compiler does something equivalent to replacing the call to fsmall with the code of fsmall itself. Then there is no call, and so there is no call overhead. 

A traditional C compiler can only inline functions for which it also knows the definition: only knowing the declaration is not enough. Therefore, programmers and compiler builders have studied the possibilities to increase inlining by making function definitions visible. Without additional support from the language, there are two strategies to do so: 
- Write all program into 1 file (sound stupid, and it is stupid)
- Functions that should be inlined are placed in header files and then included by all TUs that need them. To avoid the multiple definitions of the function symbol in each TU, such functions must be declared `static`. 

To avoid these drawbacks, C99 has introduced the `inline` keyword. Unlike what the naming might suggest, this does not force a function to be inlined, but only provides a way that it may be: 
- A function definition that is declared with `inline` can be used in several TUs without causing a multiple-symbol-definition error. 
- All pointers to the same inline function will compare as equal, even if obtained in different TUs. 
- An inline function that is not used in a specific TU will be completely absent from the binary of that TU and, in particular, will not contribute to its size. 

2 drawbacks:
- You can't create a pointer to such `inline` functions. If you need to create pointer to such function, you only need to write header of the function that you need without `inline` keyword and without parameter names.
- Function argument names and local variables are visible to the preprocessor and must be handled with care. It is handled by writing function without parameter names. The global visibility of the function definition also has the effect that local identifiers of the function (parameters or local variables) may be subject to macro expansion for macros that we don’t even know about. In the example, we used the toto_ prefix to protect the function parameters from expansion by macros from other include files. So, all identifiers that are local to an inline function should be protected by a convenient naming convention. 
- Any change you make to an inline function will trigger a complete rebuild of your project and all of its users. Only expose functions as inline if you consider them to be stable. 
- Third, other than conventional function definitions, inline functions have no particular TU with which they are associated. Whereas a conventional function can access state and functions that are local to the TU (static variables and functions), for an inline function, it would not be clear which copy of which TU these refer to. Inline functions can’t access identifiers of static functions. Inline functions can’t define or access identifiers of modifiable static objects. Here, the emphasis is on the fact that access is restricted to the identifiers and not the objects or functions themselves. There is no problem with passing a pointer to a static object or a function to an inline function. 