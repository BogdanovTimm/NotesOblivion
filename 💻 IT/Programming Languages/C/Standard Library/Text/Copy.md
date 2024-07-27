#                  Do not

- Do not try to copy larger string into a smaller one - behaviour is undefined

#                  string.h

- `strcpy(copyString, originalString)` - unsafe, because if originalSting > copyString, then behaviour is undefined. Though, it is faster than `strncpy()`
- `strcpy(copyString, originalString, sizeOf(copyString - 1))` - though it is better, it still is not unsafe because it does not inserts `'\0'` if originalString > copyString . The safiest way is:
    ```C
    strcpy(copyString, originalString, sizeof(copyString - 1));
    copyString[sizeof(copyString) - 1] = '\0';
    ```
