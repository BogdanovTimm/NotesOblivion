#                  Datatypes

Datatypes:
- numbers - 1999
- text - `'Lorem Ipsum'`, `"Lorem Ipsum"`
- dates - `'01JAN1999'd`, `TODAY()`

Other types created using `FORMATTER`.

#                  Nulls

Types of Nulls:
- numbers (empty cell looks like `.`)
- text (empty cell looks like ` `)
- dates `'01JAN1999'd`, `TODAY()`

##               Special Nulls

You can create special Nulls, for example `.A` for empty because non-answered and `.B` for empty because of incorrect data.










#                   Ceate a new informat or a view

```SAS

```









#                  Working with rows that contains both numeric and character values in one column

```Sas
proc format; 
    invalue readtemp(upcase) 
        96 - 106 = _same_ 
        'N'      = 98.6 
        other    =   .
    ; 
run; 

data temperatures; 
    input
        Temp : readtemp5. @@
    ; 

datalines; 
101 N 97.3 n N 67 104.5 
; 

```









#                  User-defined ones

```SAS
proc format; 
    invalue convert
        'A+' = 100 
        'A' = 96 
        'A-' = 92 
        'B+' = 88 
        'B' = 84 
        'B-' = 80 
        'C+' = 76 
        'C' = 72 
        'F' = 65
    ; 
run;

data grades; 
    input
        @1 ID          $3. 
        @4 Grade convert2.
    ;
 
datalines; 
001A- 
002B+ 
003F 
004C+ 
005A 
; 
```











#                  Change format

```SAS
data output_table;
    input
        new_text_format    = inputc(text_column, text_format.)
        new_numeric_format = inputn(text_column, numeric_format.)
    ;
run;
```