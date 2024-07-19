This code is slower (2 type casts):
```C#
if (given is Class1) {
    Class1 instanceOfClass1 = (Class1) given;
    given.function();
}
```

This code is faster (1 type cast):
```C#

Class1 instanceOfClass1 = given as Class1;
if (instanceOfClass1 != null) {
    given.function();
}
```