#                  Do no do!

Don’t use the `sizeof` operator on array parameters to functions.

#                  Find array size

```C
int array[3];
int array_size = (sizeof array) / (sizeof array[0]) ;
printf("%i", array_size);
```

#                  Arrays of chars and strings

Strings are a special kind of arrays that always have 0 at the end
```C
char array_of_chars[] = "Hello";
int array_size = (sizeof array) / (sizeof array[0]) ;
printf("%i", array_size); // It prints 6, because of 0 at the end
```

But simple array of chars do not have 0 at the end:
```C
char array_of_chars[5] = "Hello";
int array_size = (sizeof array) / (sizeof array[0]) ;
printf("%i", array_size); // It prints 5
```