#                  Do not

- Do not initialize an array like `{1, 2, [0] = 0, 3}`, because instead of '{0, 1, 2, 3}' you have end up with '{0, 3}'

#                  Copy array into arrayCopy

- Fastest way:
```C
memcpy(arrayCopy, array, arrayCopySize); // requires <string.h>
```
- Dumb way:
```C
for (iterator = 0; iterator < arraySize; i++) {
    arrayCopy[iterator] = array[iterator];
}
```