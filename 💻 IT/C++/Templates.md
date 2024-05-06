#                  What it is

Template is a function or a class with Java's `<GivenClass>`. 
But in C++ you need to add `template` before function's or class' name.

```cpp
#include <iostream> // New one

template <class Class1> void function(Class1* array, int arraySize) {
    Class1 safedValue;
    for (int currentPosition1 = 0;
             currentPosition1 < arraySize - 1;
             currentPosition1++) {
        int minimalPosition = currentPosition1;
        for (int currentPosition2 = currentPosition1 + 1;
                 currentPosition2 < arraySize;
                 currentPosition2++) {
            if (array[currentPosition2] < array[minimalPosition]) {
                minimalPosition = currentPosition2;
            }
        }
        safedValue = array[currentPosition1];
        array[currentPosition1] = array[minimalPosition];
        array[minimalPosition] = safedValue;
        std::cout << array[currentPosition1];
    }
    std::cout << array[arraySize - 1];
}

// Overrided function for a special class
template <int> void function(int* array, int arraySize) {
    int safedValue;
    for (int currentPosition1 = 0;
         currentPosition1 < arraySize - 1;
         currentPosition1++) {
        int minimalPosition = currentPosition1;
        for (int currentPosition2 = currentPosition1 + 1;
             currentPosition2 < arraySize;
             currentPosition2++) {
            if (array[currentPosition2] < array[minimalPosition]) {
                minimalPosition = currentPosition2;
            }
        }
        safedValue = array[currentPosition1];
        array[currentPosition1] = array[minimalPosition];
        array[minimalPosition] = safedValue;
        std::cout << array[currentPosition1];
    }
    std::cout << array[arraySize - 1];
}

int main() {
    int arrayOfInts[] = {2, 3, 1, 4};
    function(& arrayOfInts[0], 4);
    std::cout << std::endl;
    char arrayOfChars[] = {'c', 'a', 'd', 'b'};
    function(& arrayOfChars[0], 4);
    return 0; // exit code
}
```