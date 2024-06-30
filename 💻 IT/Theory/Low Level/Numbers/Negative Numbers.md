Instead of translate `-X` number using left-most bit as a negative sign, we represent `-X` as `2^number_of_bits - X`. So, if we want to repsent `-8` using 4 bits, we represent it as:
- `2^4 - 8` = `8`

The idea is that using 4 bits, there is no positive `8`, because max positive integer is `7`.
So, for 4 bits we will have:
```
Actual | Representation
-------+---------------
   0   =   0
   1   =   1
   2   =   2
   3   =   3
   4   =   4
   5   =   5
   6   =   6
   7   =   7
   8   =   -8
   9   =   -7
   10  =   -6
   11  =   -5
   12  =   -4
   13  =   -3
   14  =   -2
   15  =   -1
```

To find a negative number you need to:
1. Flip all 1s to 0s and all 0s  to 1s
2. Add 1 to it

#                  Summing negative integers

What is interesting in adding negative integers is that we always will overflow. But, we will not be bothered because of it, because this answored will always be correct, for we want this answer to be `2^number_of_bits - X` - and throwed number will be that `2^number_of_bits`