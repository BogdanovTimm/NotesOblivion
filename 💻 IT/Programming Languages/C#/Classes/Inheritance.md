#                  C++ or Java?

Java: 
- Only 1 Parent
- Every class that do not have explicit Parent class is a child of the `Object` class

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

#                  Use Parent classes or functions

```C#
base.variable;
base.function();
```

#                  `virtual`

It is the way to use child's variables and functions when they havce same names as parent ones in every moment when childs are treated as they Parents:

Parent
```C#
public class Parent {
    public            void nonVirtualFunction() {
        Console.WriteLine("Non-virtual function was called from Parent");
    }
    public    virtual void    virtualFunction() {
        Console.WriteLine("Viirtual function was called from Parent");
    }
}
```

Child
```C#
public class Child : Parent {
    public new      void nonVirtualFunction() { // new are not required, it just removes warning
        Console.WriteLine("Non-virtual function was called from Child");
    }
    public override void    virtualFunction() { // override is required
        Console.WriteLine("Viirtual function was called from Chlid");
    }
}
```

Main
```C#
Parent child1 = new Child();
child1.nonVirtualFunction(); // Non-virtual function was called from Parent
child1.virtualFunction();    //     Virtual function was called from Child

```