```C#
class ClassWithGenerics<GivenClass1, GivenClass2, GivenClass3>
        where GivenClass1 : struct
        where GivenClass2 : IComparable<GivenClass2>, IPersistable
        where GivenClass3 : OtherClass, new() { // 'new()' means that GivenClass3 has default constructor without parameters
    // ClassWithGenerics very cool body...
}
```