#                   Print table

```SAS
TITLE "Printing table";
    PROC PRINT DATA = table_to_work_with;
        FORMAT
            data_column  mmddyy10.
            /* column name, formatter, length of a output, ., amount of numbers after a dot (0 by default) */
            money_column dollar11.2
        ;
RUN;
```

#                    Print infromation about table

```SAS
TITLE "Printing information about table";
    PROC CONTENTS DATA = table_to_work_with VARNUM; /*VARNUM set order of columns to the right one, instead of an alphabetic one*/
RUN;
```

#                    Print frequences analysis

`PROC FORMAT` allows you to group values for analysis - then, the values in one gorup would be counted as a members of a group instead of themselves:

```SAS
PROC FORMAT;
    VALUE $text_format_class
        'A', 'b' = 'Male'
        'F', 'x' = 'Female'
        ' ' = 'Not entered'
        other = 'Miscoded'
    ;
RUN;

PROC FREQ DATA = schema_name.table_name;
    TITLE "Frequences analysis";
    TABLES
        text_column;
    FORMAT
        text_column $text_format_class.
    ;
```

#                    Print formatted

```SAS
PROC FORMAT;
    VALUE $text_format_class
        'M' = 'Male'
        'F' = 'Female'
        ' ' = 'Not entered'
        other = 'Miscoded'
    ;
    VALUE numeric_format_class
        low-<30 = 'Less than 30'
        30-<50 = '30 to 50'
        50<-high = '51+'
    ;
RUN;

TITLE "Print formatted";
    PROC PRINT DATA = schema_name.table_name;
    ID id_column;
    VAR text_column numberic_column;
    FORMAT
        text_column    $text_format_class.
        numeric_column numeric_format_class.
RUN;
```

#                   Print into one or second table

```SAS
DATA table1 table2;
    INPUT
        @1 text_column $1.
    ;
    IF text_column = 'F' THEN DO;
        OUTPUT table1; 
    END; ELSE IF text_column = 'M' THEN DO;
        OUTPUT table2;
    END;

DATALINES;
F
M
F
F
M
;
RUN; 
```








#                  Print Sorted

```SAS
PROC SORT DATA = database_name.table_name OUT = table_name_sorted_copy; 
    BY DESCENDING coplumn_to_sort_by; 
RUN; 
```









