#                  What it is

It is a special funciton that deals with Observer programming pattern


Publisher:
```C#
public delegate void FuncionAsClass1();

public class Publisher {
    public event FuncionAsClass1 notifyAll;

    public void functionThatNotifies() {
        Console.WriteLine("Function was called");
        notifyAll();
    }
}
```

Subscriber:
```C#
public class Subscriber {
    public void functionCalledWhenNotified() {
        Console.WriteLine("Oh, I was notified...");
    }
}
```

Main:
```C#
using ConsoleApp1;

Publisher  publisher1  = new Publisher();
Subscriber subscriber1 = new Subscriber();
// Adds subscriber1 to notify list and says that it needs to call
// 'functionCalledWhenNotified()' when it will be notified
publisher1.notifyAll += new FuncionAsClass1(subscriber1.functionCalledWhenNotified);

publisher1.functionThatNotifies();
```