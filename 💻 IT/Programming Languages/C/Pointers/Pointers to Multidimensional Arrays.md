#                  Code

```C
#include <stdio.h>

void main() {
    //  {0, 0, 0}
    //  {0, 0, 0}
    unsigned int array[2][3] = {
            {1, 2, 3},
            {4, 5, 6}
    };
    unsigned int (* currentRow)[3];//'()' is required, or it'll be 'unsigned int*'
    for (currentRow = &(array[0]);
         currentRow < &(array[2]);
         currentRow++
    ) {
        for (unsigned int iterator = 0;
             iterator < 3;
             iterator++
        ) {
            printf("[%u]", (* currentRow)[iterator]);//'()' us required
            if (iterator == 2) {
                printf("\n");
            }
        }
    }
}
```