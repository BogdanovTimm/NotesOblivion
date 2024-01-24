#                   Add a new one

```SAS
DATA output_table_name;
    SET scheme_name.table_name (KEEP = text_column numeric_column);
DATALINES;
    Lorem 69
    Inpsum 1999
RUN;
```

#                   GET

```SAS
DATA females; 
    SET scheme_name.table_name (KEEP = text_column numeric_column);
        WHERE text_column IN ('F', 'A');
        WHERE text_column IS NULL;
        WHERE text_column BETWEEN ('A', 'D'); /* A or B or C or D */
        WHERE text_column CONTAINS ('Nick'); /* Nickname, Nick */
        WHERE text_column LIKE 'R_n%'; /* Regexp: '_' means '.' and '%' means '*' */
        WHERE text_column =* 'Nick'; /* Simple '=', but non-strict (Nack, Nikki) */
RUN; 
```

#                    Fast Cumulative

```SAS
DATA output_table_name;
    SET table_to_work_with;
    RETAIN 
        new_text_column   :     $3.
        money_column2     : dollar8.;
    sum_column + money_column; /* sum_column will sum all previous values from money_column */
RUN;
```

#                    Cumulative

```SAS
DATA output_table_name;
    SET table_to_work_with;
    IF MISSING(numeric_column) THEN DO;
        counter_column + 1;
    END;
RUN;
```

#                    For-loop

```SAS
DATA table_to_work_with;
    /* SET work._prodsavail(KEEP = fullname name installed licensed);*/
    new_column1 = 0.0357;
    new_column2 = 100;
                      /* initial value TO final value BY how much to add each time  */
    DO counter_column3 = 1 TO 3 BY 1;
/* column to change += other columns or numbers */
        new_column2 + new_column1*new_column2;
        OUTPUT;
    END;
RUN;
```

##                    Nested For-loops

```SAS
DATA output_table; 
    DO group_column = 'Lorem', 'Ipsum'; 
        DO counter_column = 1 TO 5; 
            INPUT column_from_datalines @; /* @ means that you get all values from DATALINES as an input to this column */
            OUTPUT; 
        END; 
    END; 
DATALINES; 
    250 222 230 210 199 
    166 183 123 129 234 
;
```

#                    While loop

```SAS
DATA output_table;
    numeric_column = .0375;
    numeric_column2 = 100;
    
    DO WHILE (numeric_column2 >= 200);
        counter_column + 1;
        numeric_column2 = numeric_column2 + numeric_column*numeric_column2;
        OUTPUT;
    END;
    
    FORMAT
        numeric_column2 dollar10.2;
RUN;
```

##                   Untill while loop

Iterates at least once. Equal to `DO WHILE !(EXPRESSION)`

```SAS
DATA output_table;
    numeric_column = .0375;
    numeric_column2 = 100;
    
    DO UNTIL (numeric_column2 >= 200);
        counter_column + 1;
        numeric_column2 = numeric_column2 + numeric_column*numeric_column2;
        OUTPUT;
    END;
    
    FORMAT
        numeric_column2 dollar10.2;
RUN;
```

#                   For loop with while

```SAS
DATA output_table; 
    numeric_column1 = .0375; 
    numeric_column2 = 100; 
    DO counter_column = 1 TO 100 UNTIL (numeric_column2 > 200); 
        numeric_column2 = numeric_column2 + numeric_column1*numeric_column2; 
        OUTPUT; 
    END; 
    FORMAT numeric_column2 dollar10.2; 
RUN; 
```

#                 Leave

Stops loop

```SAS
DATA output_table; 
    numeric_column1 = .0375; 
    numeric_column2 = 100; 
    
    DO counter_column = 1 TO 100; 
        numeric_column2 = numeric_column2 + numeric_column1*numeric_column2; 
        OUTPUT; 
        IF numeric_column2 >= 200 THEN DO;
            leave; 
        END;
    END; 
    
    FORMAT numeric_column2 dollar10.2; 
RUN; 
```

#                  Continue

```Sas
DATA output_table; 
    numeric_column1 = .0375; 
    numeric_column2 = 100; 
    DO counter_column = 1 TO 100 UNTIL (numeric_column2 >= 200); 
        numeric_column2 = numeric_column2 + numeric_column1*numeric_column2; 
        IF numeric_column2 <= 150 THEN continue; 
        OUTPUT; 
    END; 
    FORMAT numeric_column2 dollar10.2; 
RUN;
```









#                Arrays

##               Numeric arrays

```SAS
DATA output_table;
    SET database_name.table_to_work_with;
    ARRAY new_numeric_array{3} numeric_column1 numeric_column2 numeric_column3;
    DO iterator = 1 TO 3;
        IF new_numeric_array{iterator} = 999 THEN DO;
            CALL MISSING(new_numeric_array{iterator});
        END;
    END;
    DROP iterator;
RUN;
```









###               Array fast create

```SAS
DATA output_table; 
    INPUT numeric1-numeric24 @@; 
    ARRAY numeric[24] numeric1-numeric24; 
    ARRAY numeric_second[24] numeric_second1-numeric_second24; 
    DO iterator = 1 to 24; 
        numeric_second{iterator} = (numeric{iterator} - 32)/1.8; 
    END; 
    DROP iterator; 
DATALINES; 
35 37 40 42 44 48 55 59 62 62 64 66 68 70 72 75 75 
72 66 55 53 52 50 45 
;
```







###                  Array offset

```SAS

```









##                 Character arrays

```SAS
DATA output_table; 
    SET database_name.table_to_work_with; 
    ARRAY character_array{*} $ _character_; /* [_character_] means 'every character column' */ 
    DO iterator = 1 TO DIM(character_array); /* [DIM(array_name)] returns you amount of values in the array */
        IF character_array{iterator} IN ('NA' '?') THEN DO;
            CALL MISSING(character_array{iterator}); 
		END;
    END; 
    DROP iterator; 
RUN;
```








#                  Sort

```SAS
PROC SORT DATA = database_name.table_name; 
    BY 
                   column_to_sort_by1
        DESCINDING column_to_sort_by2; 
RUN; 
```