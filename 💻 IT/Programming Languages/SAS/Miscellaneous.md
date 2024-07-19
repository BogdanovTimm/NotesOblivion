#                    What it is

Language for analysing data

#                    Comments

Types of comments:

- `/* comment */`
- `* comment ;`

#                    Types of Datatypes

- numbers (empty cell looks like `.`)
- text (empty cell looks like ` `)

Other types created using `FORMATTER`.

#                    Variables

```SAS
RETAIN
    variable1 = 0
    variable2 = 2;
variable1 = variable1+1;
```

##                   Global variables

`OPTIONS` or `TITLE`

#                    SQL to SAS translator

Row - Observation
Column - Variable
Database - Library
Table - Data-set

##                   Arithmetic

Operators:

- `SUM(61, 8);`
- `DIFF(69, 8);`
- `MULT(2, 8);`
- `DIVIDE(8, 2);`
- `RAISE(2, 9);`
- `NEGATIVE(228);` - turns 228 into -228
- `MIN(1, 4, 6);`
- `MAX(1, 4, 6);`
- `MEAN(4, 5, 6);`
- `N((Lorem, , 6, 7);` - number of non-empty elements
- `NMISS(Lorem, 6, 7);` - number of empty number elements
- `CMISS(Lorem, 6, 7);` - number of empty text elements