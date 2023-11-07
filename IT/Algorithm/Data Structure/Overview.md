There is some ways to sort Strings:
- Key-indexed sort - `O(amountOfElements + amountOfCharactersInCharacterEncoding)`. Also it is stable
- LSD Radix sort - `O(amountOfStrings * amountOfChasrsInString)`. Good when all strings are equal in their length. Also it is stable.
- MSD Radix sort - Faster than LSD Radix sort You need to reimplement String class and change how `charAt()` works. Also, it is stable (next will be something better)
- 3-way string quicksort - `O(amountOfStrings * ln(amountOfStrings))`. Not stable