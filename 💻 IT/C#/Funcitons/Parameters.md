#                  Simple types

```C#
public void function1(int     copyOfInteger,
                      ref int integer,
                      int[]   otherParameters) {
        Console.WriteLine("Function1 from Parent class was called");
        copyOfInteger = 228;
        integer = 228;
        Console.WriteLine(copyOfInteger);
        Console.WriteLine(integer);
        Console.WriteLine(otherParameters);
}
```

```C#
int variable1 = 1;
int variable2 = 2;
class1.function1(    variable1, 
                 ref variable2, 
                 new []{6, 6, 6});
Console.WriteLine(variable1); // 1
Console.WriteLine(variable2); // 228
```

#                  Classes

All rules from Java work: if you change given Class intance - it will change everywhere.

```C#
public void function2(    Child immutableAddressToMutableChild,
                      ref Child   mutableAddressToMutableChild, 
                      out Child   mutableAddressThatWillBeInitialized
                      ) {
    Child newChild = new Child();
    newChild.parentVariable1 = 228;

    immutableAddressToMutableChild      = newChild;
    mutableAddressToMutableChild        = newChild;
    mutableAddressThatWillBeInitialized = newChild;
}
```

```C#
Child child1 = new Child();
Child child2 = new Child();
Child child3 = new Child();
child1.parentVariable1 = 1;
child2.parentVariable1 = 2;
child3.parentVariable1 = 3;
parent.function2(    child1,
                 ref child2,
                 out child3
                );
Console.WriteLine(child1.parentVariable1); // 1
Console.WriteLine(child2.parentVariable1); // 228
Console.WriteLine(child3.parentVariable1); // 228
```