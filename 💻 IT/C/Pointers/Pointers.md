Always initialize pointers. 

```C
int main(int argc, char* argv[argc + 1]) {
    int  variable       =           4;
    int* address        = &(variable); // &(variable) gets address from variable
    int  variable_again = *(address ); // *(address ) gets value   from address
}
```