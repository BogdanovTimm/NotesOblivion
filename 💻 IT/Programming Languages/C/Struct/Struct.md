#                  Do not

- Do not use `typedef structute` if structure will be use in the Linked List
- Do not use a structure as an argument or as a return type for a function. Rather, use a pointer to a struct

```C
#include <stdio.h>

struct struct_type {
    int variable1;
};

void function(struct struct_type given) {
    given.variable1 = 5;
    printf("%i\n", given.variable1);
}

int main(void) {
    struct struct_type struct1 = {
        .variable1 = 1,
    };
    function(struct1);
    printf("%i\n", struct1.variable1);
    return 0;
}
```









#                  Comparing structs

Structures can be assigned with `=` but not compared with `==` or `!=`









#                  Inner structs

All struct declarations in a nested declaration have the same scope of visibility. That is, if the previous nested struct declarations appear globally, both struct s are subsequently visible for the whole C file. If they appear inside a function, their visibility is bound to the {} block in which they are found. Because of that, inner structs make no sense










#                  Struct with names

##                 Struct tag

```C
# include <stdio.h>

struct structName {
    unsigned int variable1;
    unsigned int variable2;
};

void main() {
    struct structName structNameInstance1 = {
            1,
            2
    };
    printf("%u\n", structNameInstance1.variable1);
    printf("%u\n", structNameInstance1.variable2);
}
```





##                 struct + typedef

```C
typedef struct {
    unsigned int variable1;
    unsigned int variable2;
} structName;

void main() {
    structName structNameInstance1 = {
            1,
            2
    };
    printf("%u\n", structNameInstance1.variable1);
    printf("%u\n", structNameInstance1.variable2);
}
```

```C
typedef struct struct_name struct_name;
struct struct_name{
  .variable1,
};
```








#                  Alignment

Iff type has sizeof() = 4, then it will be stored in RAM addresses that is divisible by 4. So same structure, depending on in which order you have placed its elements, will have different size:
- Not so efficient:
    ```C
    struct { // 8 bytes
        char variable1;
        int  variable2;
    }
    ```
- More efficient:
    ```C
    struct { // 5 bytes
        int  variable2;
        char variable1;
    }
    ```