#                   Add a new one

```SAS
DATA output_table_name;
    SET scheme_name.table_name(KEEP=text_column numberic_column);
DATALINES;
Lorem 69
Inpsum 1999
;
```

#                    Select

```SAS
DATA output_table_name;
    SET scheme_name.table_name(KEEP=column1 column2);
RUN;
```

##                   Union

```SAS
SET table1 table2 table3;
```

#                    Offset and Limit

```SAS
SET some_table(FIRSTOBS=2 OBS=9);
```

#                    Where

```SAS
set schema_name.table_name;
where some_column like '%LoRem%';
```

##                   Join

```SAS
DATA output_table_name;
    MERGE table1 table2 table3;
    BY common_column common_column2;
RUN;

DATA output_table_name;
    MERGE table1 table2 table3;
    BY common_column;
RUN;
```