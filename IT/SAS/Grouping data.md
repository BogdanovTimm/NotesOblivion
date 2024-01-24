#                  Count rows that in same group

```SAS
data table_to_work_with; 
    input
        number_column 
        date  : mmddyy8.
        value 
    ;

datalines;
1 02/25/2006 100
1 04/01/2006 99
1 10/10/2006 65
2 12/16/2006 77
2 05/15/2006 56
3 03/12/2006 25
run;



data counter_of_rows;
    set table_to_work_with;
    by number_column; /* Creates [first.number_column] and [last.number_column] (first and last row with that number_column) */
    if first.number_column then do;
        number_of_rows = 0; 
    end;
    number_of_rows + 1; 
    if last.number_column then do;
        output; 
    end;
run;
```

#                  Find differences










##                 FRom row to row

```SAS
data table_to_work_with; 
    input
        number_column 
        date  : mmddyy8.
        value 
    ;

datalines;
1 02/25/2006 100
1 04/01/2006 99
1 10/10/2006 65
2 12/16/2006 77
2 05/15/2006 56
3 03/12/2006 25
run;



data difference;
    set table_to_work_with;
	by number_column;
	if first.number_column and last.number_column then do;
        delete; /* Skips row if it both first and last row with that value */
	end;
	differences = value - lag(value); /* [lag(given_column)] gives you value from last use of [lag()] funtion on the column */
	if not first.number_of_column then do; /* Checks that curent row are not first one with tha value */
        output;
	end;
run;
```









##                 From first to last

```SAS
data first_last;
    set table_to_work_with;
    by number_column;
    if first.number_column and last.number_column then do;
        delete;
    end;
    if first.number_column or last.number_column then do;
        differences = value - lag(value);
    end;
    if last.number_column then do;
        output;
    end;
run;
```
Or, using `reatin`:

```SAS
data first_last_using_retain;
    set table_to_work_with;
    by number_column;
    if first.number_column and last.number_column then do;
        delete;
    end;
    retain first_value;
    if first.number_column then do;
        first_value = value;
    end;
    if last.number_column then do;
        differences2 = value - first_value;
        output;
    end;
    drop first_value;
run;
```