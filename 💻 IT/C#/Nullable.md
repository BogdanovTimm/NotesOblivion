#                  What it is

Just like in Java when you has a wrapper that says whether value within it is null or not

```C#
int? maybeNullVariable = null;
if (maybeNullableVariable.HasValue) {
    Console.WriteLine(maybeNullVariable);
}
```

#                  

- `<`, `>`, `<=`, `>=` give `false` if either one variable is `null`
- Nullable variables can't be changed via `+`, `-`, `*` or `/`:
```C#
int? nullableVariable = null;
nullableVariable = nullableVariable + 1;
Console.WriteLine(nullVariable); // Prints 'null'
```

#                  `??`

```C#
int? maybeNullableVariable = null;
int variable = maybeNullableVariable ?? 228;
Console.WriteLine(variable); // Prints '228'
int? nonNullableVariable = 1;
int variable = nonNullableVariable ?? 228; // Prints '1'
```