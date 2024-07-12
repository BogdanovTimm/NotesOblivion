Always initialize pointers. 

```C
int main(int argc, char* argv[argc + 1]) {
    int  variable       =           4;
    int* address        = &(variable); // &(variable) gets address from variable
    int  variable_again = *(address ); // *(address ) gets value   from address
}
```

#                  register

Objects with register keyword do not have address

#                  Types of pointer

- type-specific pointer `int* address` for example
- void pointer - `void* address_of_variable`
- funciton pointer - can't have void variant