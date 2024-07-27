#                  Double arrays vs arrays of poitners

It is better to use arrays of poitners, because it will have less inefficianlty used space:
```C
char arrayOfStrings[][10] = { //[NumberOfStrings][MaxSringLength]
        "Lorem", // Lorem\0\0\0\0\0
        "Ipsum", // Ipsum\0\0\0\0\0
        "Dolor", // Dolor\0\0\0\0\0
        "Sit"    // Sit\0\0\0\0\0\0
};
char* arrayOfPointers[] = {
        "Lorem", // Lorem\0
        "Ipsum", // Ipsum\0
        "Dolor", // Dolor\0
        "Sit"    // Sit\0
};
```