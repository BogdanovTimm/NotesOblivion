# What it is?

You given this algorithm a position in the array. It returns you the value of the given position if the array was sorted.

# Characteristics

In general: **O(arraySize)**
In worst case: **O(arraySize^2)**

# Code
This code uses [[Partition]] and [[Shuffle]]

```java
public class TopKElement {

    public static int select(int[] array, int positionOfElementIfArraySorted) {
        Shuffle.shuffle(array);
        int currentLeftPointer = 0;
        var currentRigthPointer = array.length - 1;
        while (currentRigthPointer > currentLeftPointer) {
            int positionOfSortedValue = Partition.partition(array, currentLeftPointer, currentRigthPointer); // Partition algorithm from [[Partition]]
            if (positionOfSortedValue < positionOfElementIfArraySorted) {
                currentLeftPointer = positionOfSortedValue + 1;
            } else if (positionOfSortedValue > positionOfElementIfArraySorted) {
                currentRigthPointer = positionOfSortedValue - 1;
            } else {
                return array[positionOfElementIfArraySorted];
            }
        }
        return array[positionOfElementIfArraySorted];
    }
}
```