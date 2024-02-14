```JAVA
public int[] merge2SortedArrays(int[] array1,
				   int amountOfElementsInArray1,
				   int[] array2,
				   int amountOfElementsInArray2) {
	int currentPositionOfLargestIntegerInArray1 = amountOfElementsInArray1 - 1;
	int currentPositionOfLargestIntegerInArray2 = amountOfElementsInArray2 - 1;
	int currentWorkingPosition = amountOfElementsInArray1 + amountOfElementsInArray2 - 1;
	while (currentPositionOfLargestIntegerInArray2 >= 0) {
		if (currentPositionOfLargestIntegerInArray1 >= 0 //
			&& array1[currentPositionOfLargestIntegerInArray1] > array2[currentPositionOfLargestIntegerInArray2]) {
			array1[currentWorkingPosition--] = array1[currentPositionOfLargestIntegerInArray1--];
		} else {
			array1[currentWorkingPosition--] = array2[currentPositionOfLargestIntegerInArray2--];
		}
	}
	return array1;
}
```