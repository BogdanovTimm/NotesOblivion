# What it is?

It is the fastest algorithm that you can use in practice. Also, it uses no space!

# Code

This code uses [[Shuffle]]

```java
public class QuickSort3WayRecursive {

    public static void sort(int[] array) {
        shuffle(array);
        innerRecursiveFunction(array, 0, array.length - 1);
    }

    private static void innerRecursiveFunction(int[] array, int leftLimiterPosition, int rightLimiterPosition) {
        if (rightLimiterPosition <= leftLimiterPosition) {
            return;
        }
        int currentLimitOfValuesLess = leftLimiterPosition;
        var currentPositionWithinEqualValues = leftLimiterPosition + 1;
        var currentLimitOfValuesLarger = rightLimiterPosition;
        int valueToSort = array[leftLimiterPosition];
        while (currentPositionWithinEqualValues <= currentLimitOfValuesLarger) {
            if (array[currentPositionWithinEqualValues] < valueToSort) { // If value from current position within values equal to value of item to sort is less then value to sort
                swap(array, currentLimitOfValuesLess++, currentPositionWithinEqualValues++);
            } else if (array[currentPositionWithinEqualValues] > valueToSort) {
                swap(array, currentPositionWithinEqualValues, currentLimitOfValuesLarger--);
            } else {
                currentPositionWithinEqualValues++;
            }
        }
        innerRecursiveFunction(array, leftLimiterPosition, currentLimitOfValuesLess - 1);
        innerRecursiveFunction(array, currentLimitOfValuesLarger + 1, rightLimiterPosition);
    }
}
```