#                  Do not

- Do not try to modify strings, decalred as pointers - they are immutable. If you try to do it - behaviour is undefined.
- Do not try to fit a larger string into a smaller array
- Do not try to work with the string as a pointer unless it points to the array
- Do not try to compare strings using `==`, `<`, `>`, `<=`, or `>=`. Insted, use `strcmp()`
- Do not try to copy string from one variable into another using `stringCopy = string`. Use `strcpy()` instead.










#                  What it is?

Strings are array of chars with the `\0` as the last character (In binary it is all 0s): `{'H' 'e' 'l' 'l' 'o' '\0'}`.
`""` stores as `{'\0'}`
Because strins are array of characters, they work similar (but not exactly) as pointers (because all arrays behave similar (but not exactly) as pointers).










#                  Working with strins

##                 Creating a new one

###                String is known at the compile time

To create a string variable :
```C
// Lines below are same
char* stringAsPointer1  = "Hello";                         // Shoul not be modified!
char  stringAsArray1[]  = "Hello";                         // Mutable. Auto array length
char  stringAsArray2[6] = "Hello";                         // Short version
char  stringAsArray3[6] = {'H', 'e', 'l', 'l', 'o', '\0'}; // Long version
```

But what if the string is less than an array itself? It will automatically add '\0' after the end of the string. The rest will be filled with '\0':
```C
// Lines below are same
char arrayOfChars1[6] = "Hel";                             // Short version
char arrayOfChars2[6] = {'H', 'e', 'l', '\0', '\0', '\0'}; // Long version
```

But what if the string is larger than an array itself? Then only those characters that fit will be saved into an array and the rest will be deleted. Also, '\0' also will be deleted, so it will be an array of chars instead of a string:
```C
// Lines below are same
char arrayOfChars1[3] = "Very long sentence"; // It is not a string!
char arrayOfChars2[3] = {'V', 'e', 'r'};      // It is not a string!
```




###                String is not known at the compile time

Work with that like this:
```C
char  arrayOfChars[stringLength + 1];
char* stringAsPointer = arrayOfChars;
stringAsPointer[0] = 'a';
stringAsPointer[1] = 'b';
stringAsPointer[2] = 'c';
```










#                  String concatenation

```C
printf("Lorem"
       "Ipsum"
); // It will print: LoremIpsum
```









#                  Find '\0'

`if(*(currentPosition))` = `if(*(currentPosition) != '\0')`

Also:
- `while(*(currentPosition))` - stops when it points to '\0'
- `while(*(currentPosition)++)` - stops right after '\0'