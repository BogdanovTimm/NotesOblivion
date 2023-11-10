# What it is?

This algorithm finds given element in the sorted array.

# Characteristics

Worst time: **O(log(arraySize))**

# Code

```java
public class BinarySearch {

    public static int find(int intToFind, int[] sortedArray) {
        int leftPointer = 0;
        int rightPointer = sortedArray.length - 1;
        while (leftPointer <= rightPointer) {
            int midPointer = (rightPointer - leftPointer) / 2 + leftPointer;
            if (intToFind < sortedArray[midPointer]) {
                rightPointer = midPointer - 1;
            } else if (intToFind > sortedArray[midPointer]) {
                leftPointer = midPointer + 1;
            } else {
                return midPointer;
            }
        }
        return -1;
    }
}
```