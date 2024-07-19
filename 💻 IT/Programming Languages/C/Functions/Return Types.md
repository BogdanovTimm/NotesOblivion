#                  Structs

Depending on the calling convention of the platform, if the return value of a function is a `struct`, the whole return value may have to be copied where the caller of the function expects the result. To return `structs`, use:
```C
struct struct_type function (struct struct_type given) {
    //...
}
```