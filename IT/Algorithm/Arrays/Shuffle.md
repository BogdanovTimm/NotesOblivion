# What it is?

This algorithm randomly shuffles an array.

# Code

```java
public class Shuffle {
    
    public static void shuffle(Object[] array) {
        int arraySize = array.length;
        var randomGenerator = new Random();
        for (int currentPosition = 0; currentPosition < arraySize; currentPosition++) {
            var currentRandomInt = randomGenerator.nextInt(currentPosition + 1);
            swap(array, currentPosition, currentRandomInt);
        }
    }
    
    public static void swap(Object[] array, int position1, int position2) {
        Object valueFromPosition1 = array[position1];
        array[position1] = array[position2];
        array[position2] = valueFromPosition1;
    }
}
```