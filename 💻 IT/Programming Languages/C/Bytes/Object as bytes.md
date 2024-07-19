Ways to work with object as array of bytes:
- using `union`
- using:
```C
#include <inttypes.h>

int main(int argc, char *argv[argc + 1]) {
    unsigned int   variable1                = 123456;
    unsigned char* variable1_as_bytes_array = (unsigned char*) &(variable1);
    for (unsigned long iterator = 0; iterator < sizeof(variable1); ++iterator) {
        printf("byte[%zu]: 0x%.02hhX\n", 
               iterator,
               variable1_as_bytes_array[iterator]);
    }
}
```