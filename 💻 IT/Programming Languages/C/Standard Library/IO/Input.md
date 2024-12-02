#                  Do not

- Don’t use `gets()` - it is unsafe because you can't define a Maximum length of a string.
- Find EOF without `feof()` - detecting a return of EOF alone is not sufficient to conclude that the end of the stream has been reached. We have to call feof to test whether a stream’s position has reached its end-of-file marker. End of file can only be detected after a failed read. 
- Do not use both `scanf()` and `getchar()` - they both wors with same buffer, so, `scnaf()` may leave some characters that `getchar()` will read.
- Do not store return value of `fgetc()`, `getc()` and `getchar()` in `char`! Store it in the `int`.
- Do not use `fread()` with text streams










#                  Unformatted text input 

- `getc(givenStream)` - for a single character from a given stream. It may be a macro. It may be caled as a function by `(getc(givenStream))`
- `fgetc(givenStream)` - `getc()` as a funciton. It is always a function. Needed for historical reasons.
- `getchar()` - gets 1 character from stdin stream. Usually it is a macro like `#define getchar() getc(stdin)`
- `fgets()` - for a string.
- `snprintf()` - when formatting output of unknown length. This function ensures in addition that no more than n bytes are ever written to s. If the return value is greater than or equal to n, the string is been truncated to fit. In particular, if n is 0, nothing is written into s.
- `ungetc()` - pushes `char` that was last get with `getc()` back to its stream.

```C
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

enum {
    buf_max = 32,
};

int main(int argc, char* argv[argc +1]) {
    int return_code = EXIT_FAILURE;
    char buffer[buf_max] = { 0 };
    for (int i = 1; i < argc; ++i) {              // Processes args
        FILE* current_file = fopen(argv[i], "r"); // as filenames
        if (current_file) {
            while (fgets(buffer, buf_max, current_file)) {
                fputs(buffer, stdout);
            }
            fclose(current_file);
            return_code = EXIT_SUCCESS;
        } else {                                  // Provides some error diagnostic
            fprintf(stderr, "Could not open %s: ", argv[i]);
            perror(0);
            errno = 0;                            // Resets the error code
        }
    }
    return return_code;
}
```



##                 Cool things

###                Get characters from a stream or file line by line

```C
while ((currentChar = getc(givenStream)) != EOF) {
    //
}
```









#                  Check errors

- `feof()` - checks whether EOF was returned (it means end-of-file)
- `ferror()` - checks whether error occured
- If neither of them was true, but there is an error - then it was a matching error - for example, functions encountered a letter while searching for a number.








#                  Formatted

##                 scanf

###                 Do not

- Do not put `\n` at the end of pattern in `scanf()`


`scanf("%d", &(usersInput));`:
- integers:
    - `%d`   - `signed int` as written with 10th base
    - `%i`   - `signed int` as written in 10th (123), 8th (0123) or 16th(0x123) base
    - `%u`   - `unsigned int` in 10th base
    - `%o`   - `unsigned int` in 8th base
    - `%x`   - `unsigned int` in 16th base
    - `%hd`  - `signed short int` in 10th base
    - `%hu`  - `unsigned short int` in 10th base
    - `%ho`  - `unsigned short int` in 8th base
    - `%hx`  - `unsigned short int` in 16th base
    - `%ld`  - `signed long int` in 10th base
    - `%lu`  - `unsigned long int` in 10th base
    - `%lo`  - `unsigned long int` in 8th base
    - `%lx`  - `unsigned long int` in 16th base
    - `%lld` - `signed long long int` in 10th base
    - `%llu` - `unsigned long long int` in 10th base
    - `%llo` - `unsigned long long int` in 8th base
    - `%llx` - `unsigned long long int` in 16th base
    - `%zu`  - `size_t`
- floats: 
    - `%f` - `%f%`, `%g` and `%e` works exactly the same for `floats`
    - `%lf`
    - `%le`
    - `%lg`
    - `%Lf`
    - `%Le`
    - `%Lg`
- strings:
    - `scanf("%228s", whereToSafeString)` - goes to secret buffer. Skips all whitespaces. When it encounters 1st non-whitespace character - then it will get characters till 1st whitespace. When called again - strats again from the place when it ened last time. Always use it like `%<Max-Width>s` to prefent writing into the RAM that is outside of an array.
    - `fgets(arrayToSafeReaded, maxNumberOfCharsToSafe, givenStream)` - reads till 1st new-line-char. Safes new-line-char.
    - `gets(arrayToSafeReaded)` - reads till 1st new-line-char. Unsafe. Never stores new-line-char
    - while-loop with `getchar()`. You need to manually add '\0' at the end:
    ```C
    int readLine(char givenArray[], int arraySize) {
        int currentCharacter;
        int currentPosition;
        while (currentCharacter != '\n') {
            if (currentPosition < arraySize) {
                givenArray[currentPosition++] = currentCharacter;
            }
        }
        givenArray[currentPosition] = '\0';
        return currentPosition; // Returns number of character stored
    }
    ```
- characters:
    - `%c`  - character or whitespace
    - ` %c` - non-white space character. Helps to avoid reading new-line character that lasts from previous call to `scanf()`
    - `getchar()` - faster than `printf()`

Rules:
- `1 2` means `1( )*2`
- ` `   means `( )*`
- `%%`  means `%`

How it works:
1. It goes into secret buffer.
2. It scans buffer using given pattern.
3. If current something to find is not `char` - then, if it finds space - it will delete it, even if it was written in a given pattern. If current something to find is `char` - it will return ' ' as a founded `char`
4. If it finds character that it needs to save into variable - it deletes it from buffer
5. If it finds character that does not exist in a given pattern, it will exit and do not delete remaining character, including the one on which it has failed.
6. Remember that after `scanf()` will do its work, there is `\n` left.

For example for input '5.6 1 10', `intVariable = 5`, `floatVariable = 0.6`, `intVariable = 1`:
```C
#include <stdio.h> 

int main(void) {
    auto int   intVariable;
    auto int   intVariable2;
    auto float floatVariable;
    scanf("%d%f%d",
          &(intVariable),
          &(floatVariable),
          &(intVariable2)
    );
    printf("Given1: [%d]\nGiven2: [%f]\nGiven3: [%d]",
           intVariable,
           floatVariable,
           intVariable2
    );
}
```




###                How to scan 123 as 1, 2, 3

```C
scanf("1%d1%d1%d", integer1, integer2, integer3);
```




###                 How to find end of the line

```C
do {
    scanf("%c", &(givenChar));
} while (givenChar != '\n')
```




###                Scan through given line

This code:
```C
while (currentChar != '\n') {
    // Do something with every char
    currentChar = getchar();
}
```

May be rewritten as:
```C
while (getchar() != '\n') {
    // Do something with every char
}
```




###                Read

```C
#include <ctype.h>
#include <stdio.h>
//#include "readline.h" // TODO: Add this

/*-----------------------------------------------------------------------------
| Description: Takes user's input and saves it into a string. Deletes trailing 
|         white-spaces.
|------------------------------------------------------------------------------
| Parameters:
|     * arrayToSafeInput - array in which user's input will be saved.
|     * arraySize        - size of the array for user's input.
|------------------------------------------------------------------------------
| Side-effects:
|    * Will change given array by saving user's input in it and by adding '\0'
|------------------------------------------------------------------------------
| Output:
|    * Number of characters saved
+----------------------------------------------------------------------------*/
int read_line(char arrayToSafeInput[], int arraySize) {
    // v------------------- VARIABLES --------------------v
    int chcurrentChar;
    int currentPosition = 0;
    // ^------------------- VARIABLES --------------------^

    while (isspace(chcurrentChar = getchar())) // Deleting of trailing white-spaces
    ;
    while (chcurrentChar != '\n' && chcurrentChar != EOF) { // Reading characters 1 by 1
        if (currentPosition < arraySize)
            arrayToSafeInput[currentPosition++] = chcurrentChar;
        chcurrentChar = getchar();
    }
    arrayToSafeInput[currentPosition] = '\0'; // Add '\0' at the end of the string
    return currentPosition;
}

int main(void) {
    char string[20];
    read_line(string, 20);
    for(unsigned int i = 0; i < 20; i++) {
        printf("%c", string[i]);
    }
}
```