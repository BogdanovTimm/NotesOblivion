#                  Do not

- Dont' create pointers to addresses of block-scope (local). Therefore, it is good practice to mark all variables in complex code with `register`.

Always initialize pointers. 

```C
int main(int argc, char* argv[argc + 1]) {
    int  variable       =           4;
    int* address        = &(variable); // &(variable) gets address from variable
    int  variable_again = *(address ); // *(address ) gets value   from address
}
```

#                  register

##                 Do not

- Create arrays with `register` - they are useless, because you can't access them.

Objects with register keyword do not have address, so you can't use `&(registerVariable))`.
Declare local variables that are not arrays in performance-critical code as `register`. 

#                  Types of pointer

- type-specific pointer `int* address` for example
- void pointer - `void* address_of_variable`
- funciton pointer - can't have void variant