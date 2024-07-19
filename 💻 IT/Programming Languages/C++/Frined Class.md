#                  What it is

It is when `Class2` may use variables and function sfrom `Class1`:

```cpp
class Class1 {
    private:
        int variable1 = 5;
        friend class Class2;
}
class Class2 {
    int variable2 = variable1;
}
```