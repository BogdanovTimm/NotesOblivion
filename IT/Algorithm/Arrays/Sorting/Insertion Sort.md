# What it is?

It is not so fast sorting algorithm, so never use it! But it is easy to remember, so you can use it on the interview.

# Characteristics

In general: **O(arraySize)**
In the worst case: **O(arraySize^2)**

# Code

```java
public class InsertionSort {

    public static void sort(int[] array) {
        int arraySize = array.length;
        for (int currentPositionToSort = 0;
             currentPositionToSort < arraySize;
             currentPositionToSort++) {
            for (int currentSortedPosition = currentPositionToSort;
                 currentSortedPosition > 0;
                 currentSortedPosition--) {
                if (array[currentSortedPosition] < array[currentSortedPosition - 1]) {
                    swap(array, currentPositionToSort, currentSortedPosition - 1);
                } else {
                    break;
                }
            }
        }
    }
    
    public static void swap(int[] array, int position1, int position2) {
        int valueFromPosition1 = array[position1];
        array[position1] = array[position2];
        array[position2] = valueFromPosition1;
    }
}
```