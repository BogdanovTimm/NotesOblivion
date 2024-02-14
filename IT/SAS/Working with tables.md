#                    Join

```SAS
DATA output_table_name;
    MERGE
        table1
        table2 (RENAME = (table2_column = table1_column))
        table3
        ;
            BY common_column common_column2;
RUN;

DATA output_table_name;
    MERGE 
        table1
        table2
        table3
        ;
            BY common_column;
RUN;
```

##                   Join Inner

```SAS
DATA output_table; 
    MERGE 
        table1 (IN = InTable1) 
        table2 (IN = InTable2)
        ; 
            BY join_column; 
    IF InTable1 AND InTable2; 
RUN; 
```

###                 Join Inner and special table for missing ones

```SAS
DATA output_table;
    missing_name (DROP = column1);
    MERGE
        table1 (IN = InTable1) 
        table2 (IN = InTable2); 
            BY join_column; 
    IF InTable1 AND InTable2 THEN DO;
        OUTPUT output_table;
    END; ELSE IF InTable1 AND NOT InTable2 THEN DO;
        OUTPUT missing_name;
    END;
RUN; 
```


##                   Join Left

```SAS
DATA output_table; 
    MERGE
        table1 (IN = InTable1) 
        table2 (IN = InTable2); 
            BY join_column; 
    IF InTable1 AND InTable2; 
RUN; 
```

##                   Join when columns have different types

Sometimes, there is `numeric_column` in `table1` and `text_column` in `table2`.

###                  Numeric, date, etc into text

```SAS
DATA table1_copy;
    SET table1;
    text_column = PUT(numeric_column, ssn11.); /* put is equal to [sout.println()] */
    DROP numeric_column;
    RUN;

DATA output_table;
    MERGE
        table1_copy
        table2
        ;
            BY text_column; 
RUN;
```

###                  Text into numeric

```SAS
DATA table1_copy;
    SET table1;
    numeric_column = INPUT(COMPRESS(text_column, '-'), 9.); /* COMPRESS() deletes '-' symbol */
    numeric_column = INPUT
    DROP text_column;
    RUN;

DATA output_table;
    MERGE
        table1_copy
        table2
        ;
            BY numeric_column; 
RUN;
```










#                  Text into everything

```SAS
###                  Text into numeric

```SAS
DATA table1_copy;
    SET table1;
    numeric_column = INPUT(COMPRESS(text_column, '-'), 9.); /* COMPRESS() deletes '-' symbol */
    numeric_column = INPUT
    DROP text_column;
    RUN;

DATA output_table;
    MERGE
        table1_copy
        table2
        ;
            BY numeric_column; 
RUN;
```
```


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
        mtable1y_column  : dollar8.
    ;
	FORMAT
	/* %column name%  %format% . %number of integers after dot% */
        date_column  DATE9.
        mtable1y_column DOLLAR8.2
    ;
    DATALINES;
        "M",50,11/12/1955,"$45,200"
        "F",23,11/12/1955,"$45,200"
        "M",65,11/12/1955,"$45,200"
        "F",35,11/12/1955,"$45,200"
        "M",15,11/12/1955,"$45,200"
RUN;
```

```SAS
DATA output_table; 
    INFILE DATALINES DELIMITER = ' ,'; /* Blanks or commas are delimiters */
    INPUT 
        #1 line1         $ 30. /* #1 means 1st line (or X+1th line) */
        #2 line2         $ 40. 
        #3 line3_city  & $ 20. /* [&] means that it goes to another row or column where it finds 2 or more whitespaces*/
           line3_state : $  2.  /* [:] means that it goes to another row or column where it finds 1 whitespace*/
           line3_zip   : $  5.
    ; 
    line1 = TRANWRD(line1,'Mr.',' '); 
    line1 = TRANWRD(line1,'Mrs.',' '); 
    line1 = TRANWRD(line1,'Dr.',' '); 
    line1 = TRANWRD(line1,'Ms.',' '); 
    line1 = LEFT(line1); 
    line2 = TRANWRD(line2, 'Street', 'St.' ); 
    line2 = TRANWRD(line2, 'Road'  , 'Rd.' ); 
    line2 = TRANWRD(line2, 'Avenue', 'Ave.'); 
DATALINES; 
Dr. Peter Benchley 
123 River Road 
Oceanside, NY 11518 
Mr. Robert Merrill 
878 Ocean Avenue 
Long Beach, CA 90818 
Mrs. Laura Smith 
80 Lazy Brook Road 
Flemington, NJ 08822 
; 
```


#                    Read table from a file











##                 Do something special when file ends

```SAS
data _null_; 
    file print; 
    infile 'c:\books\learning\month.txt' end = last; 
    input
        @1 Month $3. 
        @5 MonthTotal 4.; 
    YearTotal + MonthTotal; 
    
    if last then 
        put "Total for the year is" YearTotal dollar8.; 
run; 
```











##                   By lines

Because the default logical reord length on Windows and UNIX systems is 256 bytes, you need to use the INFILE option LRECL to specify record lengths greater than 256.  Suppose you are given a raw data file (Long.txt) where each line ontains 3,000 bytes. 
In order to read this file, you need to specify the record length, like this: 
`infile 'long.txt' lrecl=3000;`
If you use the PAD option in combination with the LRECL option, all the records are padded to whatever you specify for the LRECL. 

###                Read multiple files

```SAS
data combined; 
    if finished = 0 then
        infile 'alpha.txt' end=finished; 
    else infile 'beta.txt'; 
    ... 
run; 
```

You can do same by

```SAS
 filename bilbo ('alpha.txt' ‘beta.txt'); 
 data combined; 
 infile bilbo; 
 input . . .; 
 . . . 
 run; 
```



















##                 Read table where there is different columns

```sas
data survey; 
    infile 'c:\books\learning\survey56.txt' pad; 
    input 
        @9 year $4.; @;
    
    if year = '2005' then 
        input
            @1 Number 
            @4 Q1 
            @5 Q2 
            @6 Q3 
            @7 Q4
    ; else if year = '2006' then 
        input
            @1 Number 
            @4 Q1 
            @5 Q2 
            @6 Q2B 
            @7 Q3 
            @8 Q4
    ; 
run; 
```

###                  .txt file

By default, values must be separated by ` `.

```SAS
DATA table_to_work_with;
    INFILE 'c:\books\learning\mydata.txt' TRUNCOVER;
    INPUT
        text_column     :       $3.
        numeric_column  :       20.
        date_column     : mmddyy10.
        mtable1y_column : dollar8.
    ;
RUN;
```

###                  .csv file

In .csv file values must be separated by `,`, and text values must be in `""`.

```SAS
DATA table_to_work_with;
    INFILE 'c:\books\learning\mydata.csv' DSD TRUNCOVER;
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

#                    Dates columns

```SAS
DATA four_dates; 
    INPUT
        @1  id_column         $3. 
        @5  date_column1 mmddyy10.
        @16 date_column2 mmddyy8.
        @26 date_column3 mmddyy8.
        @34 date_column4   date9.
    ;
	date_differences_column = INT(YRDIF(date_column1, '01JAN1999'd, 'Actual'));
    FORMAT
        date_column1 date_column2    date9.
	    date_column3 date_column4 mmddyy10.
	;

DATALINES;
001 10/21/1950 05122003 08/10/65 23Dec2005 
002 01/01/1960 11122009 09/13/02 02Jan1960
    ;/* id date_column1 date_column2 date_column3 date_column4*/
RUN;
```

#                    Union two tables into one

```SAS
DATA table3; 
    SET table1 table2; 
RUN; 
```

##                   Union two tables into one and sort

The most efficient way is to sort tables before merging them:

```SAS
PROC SORT DATA = table1; 
    BY numeric_column; 
RUN; 

PROC SORT DATA = table2; 
    BY numeric_column; 
RUN ; 

DATA sorted_tables; 
   SET table1 table2; 
       BY numeric_column; 
RUN;
```

#                    Update table1 by rows in table2

```SAS
DATA output_table; 
    UPDATE
        table1
        new_table1
        ; 
            BY some_column; 
RUN; 
```