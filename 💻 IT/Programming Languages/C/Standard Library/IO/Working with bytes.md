#                   Do not

- Think that files written using binary is portable
- Do not `fwrite` structs that has pointers as its value - when it will be read back, pointers may be invalid.









#                  ALways do

2.14.4.1 Open streams on which you use fread or fwrite in binary mode. 









#  s

- `fread(givenArray, sizeOf1ArrayElement, maxNumberOfArrayElementsToRead, givenStream);` - reads a given number of elements into a given array from a given stream. Returns number of actually readed elements
- Writing into a stream `fwrite(givenObject, sizeOf1Element, maxNumberOfElementsToWrite, givenStream)`:
    - `fwrite(givenArray, sizeof(givenArray[0]), sizeof(givenArray) / sizeof(givenArray[0]), givenStream)` - writes a given number of elements of a given array into a given stream. . Returns number of actually written elements
    - `fwrite(&(givenStruct), sizeof(givenStruct), 1, givenStream)` - writes a struct into a given stream. . Returns number of actually written structs
- `fseek(FILE* stream, long int offset, int whence);`
- `ftell(FILE* stream);`









#                  Example

```C
#include <stdio.h>
#include <stdlib.h>

// v--------------------------------------------------- VARIABLES ----------------------------------------------------v
# define NAME_LEN 25
# define MAX_PARTS 100

struct structName {
    int  number;
    char name[NAME_LEN+1];
    int  on_hand;
} arrayOfStructName[MAX_PARTS]; // Same as  'struct part inventory[MAX_PARTS]''

int numberOfStructNamesInFile;
// ^--------------------------------------------------- VARIABLES ----------------------------------------------------^









// v---------------------------------------------------- PROGRAM -----------------------------------------------------v
int main(void) {
    FILE* file;
    int currentStructNamePosition;

    if ((file = fopen("inventory.dat", "rb+")) == NULL) { // Open file to both read and write. Check whether file was opened successfully.
        fprintf(stderr, "Can't open inventory.dat\n");
        exit(EXIT_FAILURE);
    }

    numberOfStructNamesInFile = fread( // Saves all strucNames from a file into an [arrayOfStructName].
        arrayOfStructName,             // Also, saves number of structNames in a file into [numberOfStructNamesInFile]
        sizeof(struct structName),
        MAX_PARTS,
        file
    );

    for (currentStructNamePosition = 0; currentStructNamePosition < numberOfStructNamesInFile; currentStructNamePosition++) {
        arrayOfStructName[currentStructNamePosition].on_hand = 0;
    }

    rewind(file); // Clear everything so we will be write new structs into a file from the start, not add a new ones.
    fwrite(arrayOfStructName, sizeof(struct structName), numberOfStructNamesInFile, file); // Writes new structs into a file.
    fclose(file); // Close a stream to a file.
    
    return 0;
}
// ^---------------------------------------------------- PROGRAM -----------------------------------------------------^
```