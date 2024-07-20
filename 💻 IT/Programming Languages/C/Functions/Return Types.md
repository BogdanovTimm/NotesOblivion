#                  Do not

- Do not return address of (pointer to) an `auto` (the deafult one) variable from a function:
```C
int* function() { // Do not do this!
    auto int variable = 1;
    return &(variable);
}
```

#                  Structs

Depending on the calling convention of the platform, if the return value of a function is a `struct`, the whole return value may have to be copied where the caller of the function expects the result. To return `structs`, use:
```C
struct struct_type function (struct struct_type given) {
    //...
}
```