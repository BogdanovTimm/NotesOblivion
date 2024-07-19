#                  What it is

Just like in Java:
- Every function must be abstract
- 1 class may have implement different interfaces
- Each variable and funciton is public
- You can't initialize interface

Interface:
```C#
public interface InterfaceForClass {
    int variable { get; }
    void function(int intParameter);
}
```

Child:
```C#
class Class : InterfaceForClass {
    public void function(int intParameter) {
        // ...
    }
}
```

#                  Special feature


Interface:
```C#
public interface InterfaceForClass {
    int variable { get; }
    void function(int intParameter);
}
```

Class that implemets interface:
```C#
public class Class : InterfaceForClass {
    public int variable { get; }

    void InterfaceForClass.function(int intParemeter) {
        Console.WriteLine("Function that can be called only from Iterface is called");
    }
    
    public void function(int intParameter) {
        Console.WriteLine("Functon was called from Chlid");
    }
}
```

Main:
```C#
Class classInstance = new Class();
classInstance.function(4); // Funciton was called from Child

InterfaceForClass classInstance2 = new Class();
classInstance2.function(4); // Function that can be called only from Interface is called
```