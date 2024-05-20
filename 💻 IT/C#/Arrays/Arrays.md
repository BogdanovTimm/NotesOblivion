#                  Types of arrays

Types of arrays:
- Arrays of ints, doubles, etc
- Array of arrays:
    - Array of arrays with same size (прямоугольный)
    - Arrya of arrays with different sizes (ступенчатый)

#                  Arrya of Class instances

```C#
Class[] arrayofClassInstances = new Class[3];

for (int iterator = 0; iterator < arrayofClassInstances.Length; iterator++) {
    arrayofClassInstances[iterator] = new Class();
}
```

Same as in Java

```C#
int[] arrayOfInts = {1, 9, 2};

int[] copyOfArrayOfInts = arrayOfInts;
copyOfArrayOfInts[0] = 228;

Console.WriteLine(arrayOfInts[0]); // 228
```

#                  Array of arrays

##                 With same size

```C#
int[,] arrayOfArrays = {{1, 2}, {3, 4}};
int[,] arrayOfArrays2 = new int[2, 3];
```

##                 With different size

```C#
int[][] arrayOfArrays = {new int[2], new int[3]};
int[][] arrayOfArrays2 = new int[2][];
```