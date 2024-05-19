```C#
Console.WriteLine("Start...");

int variable1 = 1;

switch (variable1) {
    case 1:
        goto case 2;
        Console.WriteLine("You can't see this");
        break;
    case 2:
        Console.WriteLine("Variable1 = 2");
        break;
}
```

```C#
Console.WriteLine("Start...");

int variable1 = 1;

switch (variable1) {
    case 1:
        goto default;
        Console.WriteLine("You can't see this");
        break;
    default:
        Console.WriteLine("Now you are in the deafault one");
        break;
}
```