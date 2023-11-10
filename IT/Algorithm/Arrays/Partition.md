# What it is?

Makes such that all values will be less than `leftLimiterPosition` will be at the left part of the array, and all values that are larger than `leftLimiterPosition` will be at the right part of the array.

![[Untitled-2023-11-10-1121.png]]

Also, it means that this value is sorted.

# Code

```java
public class Partition {
	public static int partition(int[] array, int leftLimiterPosition, int rightLimiterPosition) {
		int currentPositionOfOptionalValueLessThanMidValue = leftLimiterPosition;
		int currentPositionOfOptionalValueLargerThanMidValue = rightLimiterPosition + 1;
		int midValue = array[leftLimiterPosition];
		while (true) {
			while (array[++currentPositionOfOptionalValueLessThanMidValue] < midValue) {
                if (currentPositionOfOptionalValueLessThanMidValue == rightLimiterPosition) {
                    break;
                }
            }
            while (midValue < array[--currentPositionOfOptionalValueLargerThanMidValue]) {
                if (currentPositionOfOptionalValueLargerThanMidValue == leftLimiterPosition) {
                    break;
                }
            }
            if (currentPositionOfOptionalValueLessThanMidValue >= currentPositionOfOptionalValueLargerThanMidValue) {
                break;
            }
            swap(array, currentPositionOfOptionalValueLessThanMidValue, currentPositionOfOptionalValueLargerThanMidValue);
        }
        swap(array, leftLimiterPosition, currentPositionOfOptionalValueLargerThanMidValue);
        return currentPositionOfOptionalValueLargerThanMidValue; //? Actually, after swap, it is a sorted position of midValue
    }
    
	public static void swap(int[] array, int position1, int position2) {
        int valueFromPosition1 = array[position1];
        array[position1] = array[position2];
        array[position2] = valueFromPosition1;
    }
}
```