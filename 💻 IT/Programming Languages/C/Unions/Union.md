Union allows you do define 2 or more representation of a 1 object. For example, to allow its representation as an int and as a bytes:
```C
#include <inttypes.h> 

typedef union union_name union_name; // Trick to shorten writing union
union union_name {
    unsigned int  as_integer;
    unsigned char as_byte_array[sizeof(unsigned int)];
};

int main(int argc, char* argv[argc + 1]) {
    union_name union_name_instance = { .as_integer = 12345 , };
    printf("value is 0x%.08X\n", union_name_instance.as_integer);
    for (unsigned long i = 0;
         i < sizeof(union_name_instance.as_byte_array);
         ++i
    ) {
        printf("byte[%zu]: 0x%.02hhX\n",
               i,
               union_name_instance.as_byte_array[i]
        ); 
    }
}
```

Unions may be copied using `=`