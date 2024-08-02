Write into a string:
- `snprintf(givenArrayOfChars, maxNumberOfCharsToWriteINcludingZero, givenTransformationString, ...)` - like `sprintf()` but you can also define a max number of characters to write.
- `sprintf(givenArrayOfChars, givenTransformationString, ...)` - not safe, because number of characters in a given transformation string may be > given array of chars' size. Writes given transformation string into a given array of chars, add '\0'. Returns number of written chars (it does not count '\0')

Read from a string:
- `scnaf(givenString, givenTransformationString, ...)`