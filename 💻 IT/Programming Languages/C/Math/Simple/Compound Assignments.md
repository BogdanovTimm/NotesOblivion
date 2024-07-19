#                  Do not

- Do not use `variable = variable + 5`. Its output is undefined.

#                  What it is

It is when you use current value of a variable to compute a new one.

#                  Code

```C
register unsigned int variable = 1;
variable  = variable + 5; // DO NOT USE IT! But it is Compound Assignment.
variable += 5;            // Compound Assignment. Same as the one above
variable++;               // Compound Assignment. It is not faster than the one above
++variable;               // Compound Assignment. It is not faster than the second above
variable =+ 5;            // NOT a Compound Assignment! It is 'variable = 5;'
```

#                  Prefix vs Postfix

```C
register unsigned int variable1 = 1;
printf("%d", variable1++); // Prints: 1
printf("%d", variable1  ); // Prints: 2
register unsigned int variable2 = 1;
printf("%d", ++variable1); // Prints: 2
printf("%d",   variable1); // Prints: 2
```