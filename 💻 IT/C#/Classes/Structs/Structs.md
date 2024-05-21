#                  Differences from classes

- Struct keeps values of a variables, instead of a references to the values. Hence, struct is keeped in stack (instead of a heap)
- Struct can't have children or parents
- Struct can implements interfaces
- Struct can't override constructors
- Struct can't have descrtuctor functions
- Struct can't be `protected`
- Struct can be `private` only if it is inner
- Variables and functions within structs can't be `protected` or `protected internal`
- Struct can't be `abstract`
- Struct's functions can't be `abstract` or `virtual`
- Struct's non-`static` variables can't be initialized
- Only functoins from Object class can be with `override`