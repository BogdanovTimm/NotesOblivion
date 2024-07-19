```C#
using ConsoleApp1;

Child child1 = new Child();
Console.WriteLine(child1.GetType()); // Chlid

Parent child2 = new Child();
Console.WriteLine(child2.GetType()); // Child
```