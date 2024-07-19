```C#
public class Class1 {
    public void function1() {
        lock (this) {
            Thread.Sleep(3000);
            Console.WriteLine("Function1 was called from " + Thread.GetDomain());
        }
    }
}
```

Main:
```C#
Class1 class1Instance = new Class1();
Thread thread1 = new Thread(class1Instance.function1);
Thread thread2 = new Thread(class1Instance.function1);

Console.WriteLine("Thread 1 is starting...");
thread1.Start();
Console.WriteLine("Thread 2 is starting...");
thread2.Start();
// Because thread1 and thread2 use same function - thread2 will wait for
// thread1 to finish
```