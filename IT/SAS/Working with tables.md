#                    Merge tables

##                   Union

```SAS
SET table1 table2 table3;
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

#                    Read table from existing table

```SAS
DATA table_to_work_with;
    SET library_name.table_name(keep=text_column1 text_column2 numeric_column1 numeric_column2);
    new_column = licensed + 1;
RUN;
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

#                    Read from program itself

```SAS
DATA new_table;
    INFILE DATALINES DSD DELIMITER=',';
    INPUT
	/* %column name% : %format% . %cell length% %number of integers after dot% */
        text_column      :      $3.
        numeric_column   :       2.
        date_column      : mmddyy10.
        money_column     : dollar8.
    ;
	FORMAT
	/* %column name%  %format% . %number of integers after dot% */
        date_column  DATE9.
        money_column DOLLAR8.2
    ;
    DATALINES;
        "M",50,11/12/1955,"$45,200"
        "F",23,11/12/1955,"$45,200"
        "M",65,11/12/1955,"$45,200"
        "F",35,11/12/1955,"$45,200"
        "M",15,11/12/1955,"$45,200"
RUN;
```

#                    Read table from a file

##                   By lines

###                  .txt file

By default, values must be separated by ` `.

```SAS
DATA table_to_work_with;
    INFILE 'c:\books\learning\mydata.txt';
    INPUT
        text_column    :       $3.
        numeric_column :       20.
        date_column    : mmddyy10.
        money_column   : dollar8.
    ;
RUN;
```

###                  .csv file

In .csv file values must be separated by `,`, and text values must be in `""`.

```SAS
DATA table_to_work_with;
    INFILE 'c:\books\learning\mydata.csv' DSD;
    INPUT text_column1 $ numeric_column1 numeric_column2; 
RUN;
```

###                  Change a delimeter

```SAS
DATA table_to_work_with;
    INFILE 'c:\books\learning\mydata.txt' DELIMETER=', ';
    INPUT text_column1 $ numeric_column1 numeric_column2; 
RUN;
```

##                   Formatter

```SAS
DATA new_table;
    INFILE 'c:\books\learning\bank.txt';
    INPUT
        *Start of the column in file, column name, text/numeric/formatted, length of column in file .;
        @1  text_column1 $3.
        @4  text_column2 mmddyy10.
        @14 text_column3 $1.
        @15 numeric_column 7.
    ;
RUN;
```