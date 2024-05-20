#                  Call Constructor1 before Constructor2

```C#
using System.Runtime.CompilerServices;

namespace ConsoleApp1; 

public class Parent {
    public string stringVariable = 0;
    public int intVariable = 0;

    public Parent(string givenString) {
        this.stringVariable = givenString;
    }
    
    // Calls default constructor before itself using ': this()'
    public Parent(int integer) : this("Lorem") {
        this.intVariable = integer;
    }
}
```

```C#
Parent parent1 = new Parent("Hello");
Parent parent2 = new Parent(228);
Console.WriteLine(parent1.stringVariable + " " + parent1.intVariable); // Hello 0
Console.WriteLine(parent2.stringVariable + " " + parent2.intVariable); // Lorem 228
```

#                  Call constructor of Parent

```C#
namespace ConsoleApp1; 

public class Child : Parent {
    public int parentVariable1 = 10;

    public Child() : base("Hello") { // calls Parent("Hello");
        Console.WriteLine("Constructor from Child was called...");
    }
}
```