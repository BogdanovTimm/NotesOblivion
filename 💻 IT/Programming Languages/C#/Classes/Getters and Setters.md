```C#
using Microsoft.VisualBasic.CompilerServices;

namespace ConsoleApp1; 

public class Class {
    private int integerVariable;

    public int getter {
        get => integerVariable;
    }

    public int setter {
        set => integerVariable = value;
    }

    public int getterAndSetter {
        set => integerVariable = value;
        get => integerVariable;
    }
}
```

```C#
using ConsoleApp1;

Class class1 = new Class();
Console.WriteLine(class1.getter); // 0

class1.setter = 9;
Console.WriteLine(class1.getter); // 9

int outputFromGetterAndSetter = class1.getterAndSetter = 228;
Console.WriteLine(outputFromGetterAndSetter); // 228
Console.WriteLine(class1.getterAndSetter); // 228

```