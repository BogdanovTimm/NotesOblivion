#                  private, internal protected, protected, internal, public

- `private` (default) - only within this class
- `internal protected` - only within this class and childs in these colution
- `protected` - only within this class and childs
- `internal` - only within these solution
- `public` - not restricted

#                  `new`

Allows to reassign variables and funciton in child classes (In Java it is enabled by default).

```C#
namespace ConsoleApp1; 

public class Parent {
    public int parentVariable1 = 1;

    public void function1() {
        Console.WriteLine("Function1 from Parent class was called");
    }
}
```

```C#
namespace ConsoleApp1; 

public class Child : Parent {
    public new int parentVariable1 = 10;

    public new void function1() {
        Console.WriteLine("Funciton1 was called from Child");
    }
}
```

```C#
using ConsoleApp1;

Parent parent = new Parent();
Child child = new Child();
Console.WriteLine(parent.parentVariable1); // From Parent
Console.WriteLine(child.parentVariable1);  // From Child
parent.function1(); // Function1 was called from Parent
child.function1();  // Function1 was called from Chlid
```

