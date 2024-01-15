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