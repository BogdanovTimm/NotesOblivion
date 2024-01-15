#                    Conditional column

```SAS
DATA new_table;
 	SET schema.table_to_work_with (KEEP = text_column numeric_column);
    LENGTH new_column $ 10;
	IF MISSING(text_column) THEN
	    new_column = " "
    ; ELSE IF installed = "Lorem" THEN
	    new_column = 'Ipsum'
    ;
RUN;
```

#                    Conditional rows

Deletes all rows that do not pass if-statement:

```SAS
DATA new_table;
 	SET schema.table_to_work_with (KEEP = text_column numeric_column);
	IF text_column IN ('A', 'B');
RUN;
```

##                   Using SELECT

```SAS
DATA new_table;
    SET scheme_name.table_to_work_with (KEEP=text_column numeric_column);
    SELECT;
        WHEN (MISSING(text_column))
            new_column = " "
        ; WHEN (installed = "Lorem")
            new_column = 'Ipsum'
        ; OTHERWISE
        ;
    END; 
RUN;
```