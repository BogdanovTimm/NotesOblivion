#                  Indexator aka Getters and Setters for arrays within a class

Very dumb

```C#
using Microsoft.VisualBasic.CompilerServices;

namespace ConsoleApp1; 

public class Class {
    private int integerVariable;
    private int[] arrayOfIntegers;

    public int this[int integer, int integer2] {
        get { // For int vraiable = classInstance[integer1, integer2]; OR Console.WriteLine(classInstance[integer1, integer2])
            return arrayOfIntegers[integer];
        }
        set { // For classInstance[integer1, integer2] = value;
            arrayOfIntegers[integer] = value;
            arrayOfIntegers[integer2] = value;
        }
    }
}
```

```C#
Class classInstance = new Class();
classInstance[0, 1] = 2;                // {2, 2}
Console.WriteLine(classInstance[0, 1]); // Return first
```