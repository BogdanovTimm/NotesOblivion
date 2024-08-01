#                  What it is?

If you define macro-function with same name as a function - then, you hide origianl funciton with macro that has same name. You may want it because calling macro is faster than calling a function.









#                  Call original funciton

Just put name of a function in `()`:

```C
function();   // It calls macro
(function)(); // It calls original funciton
```