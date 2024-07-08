Count digits that larger and smaller than 1.0:
```C
for (size_t i = 0; i < N; ++i) { 
    arrayCounter[(oldArray[i] <= 1.0)] += 1;
}
```