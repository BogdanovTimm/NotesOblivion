# What it is?

It is the sorting algorithm with fastest worst case. Use it if you need stable sorting time (for example for NASA rockets or hearth implants).

# Characteristics

Worst case time: **O(arraySize * log(arraySize))**
Memory usage: **O(log(arraySize))**
Stable: **No**

# Code

```java
public class MergeSortRecursiveForInts {

    public static void sort(int[] array) {
        var arrayOfCopies = new int[array.length];
        recursiveSort(array, arrayOfCopies, 0, array.length - 1);
    }  

    private static void recursiveSort(int[] array,
                                      int[] arrayOfCopies,
                                      int leftPosition,
                                      int rightPosition) {
        if (rightPosition <= leftPosition) {
            return;
        }
        var midPosition = findMid(leftPosition, rightPosition);
        recursiveSort(array, arrayOfCopies, leftPosition, midPosition);
        recursiveSort(array, arrayOfCopies, midPosition + 1, rightPosition);
        merge(array, arrayOfCopies, leftPosition, midPosition, rightPosition);
    }

    public static void merge(int[] array,
                             int[] arrayForCopies,
                             int leftPointer,
                             int midPointer,
                             int rightPointer) {
        for (int currentPointer = leftPointer; currentPointer <= rightPointer; currentPointer++) {
            arrayForCopies[currentPointer] = array[currentPointer];
        }
        int currentPositionInSubArray1 = leftPointer;
        int currentPositionInSubArray2 = midPointer + 1;
        for (int currentPositionInArray = leftPointer;
             currentPositionInArray <= rightPointer;
             currentPositionInArray++) {
            if (currentPositionInSubArray1 > midPointer) {
                array[currentPositionInArray] = arrayForCopies[currentPositionInSubArray2++];
            } else if (currentPositionInSubArray2 > rightPointer) {
                array[currentPositionInArray] = arrayForCopies[currentPositionInSubArray1++];
            } else if (arrayForCopies[currentPositionInSubArray2] < arrayForCopies[currentPositionInSubArray1]) {
                array[currentPositionInArray] = arrayForCopies[currentPositionInSubArray2++];
            } else {
                array[currentPositionInArray] = arrayForCopies[currentPositionInSubArray1++];
            }
        }
    }

    public static int findMid(int lo, int hi) {
        return lo + (hi - lo) / 2;
    }
}
```