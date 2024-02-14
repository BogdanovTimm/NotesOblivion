It can be realised with `Binary Heap Tree` data structure.

# Binary Heap Tree graph

1 parent has 0, 1 or 2 children.

Parent's value always > value of its child.

## Array Representation

`array[0]` = null

`array[1]` = root node.

Find parent (it works for both of its chlidren because Java throws away everything after '.' in division of integers):
```
childValue / 2
```

Find parent:
```java
if (childValue % 2 = 0) {
    return childValue * 2;
} else {
    return (childValue * 2) + 1;
}
String string = "ANus";
```
