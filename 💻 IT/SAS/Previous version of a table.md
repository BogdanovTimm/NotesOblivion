#                  Get previous version of a table

Don't use `LAG(table_name)` with `IF`

```SAS
DATA output_table; 
    INPUT column1 column2; 
    current_minus_previous = column2 – lag(column2);

DATALINES;
1 60
2 62
 65
4 70
;
```