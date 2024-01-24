#                    Default length of the columns

- Text column - 8 characters
- Numeric column - 14 integers

#                    Create a new one

```SAS
DATA output_table_name;
    SET table_to_work_with;
    LENGTH "text_column"n $17; */n means that it is a literal in "" $ means that this is a text column. 17 sets length/*
    "text_column"n="Lorem Ipsum";
    "number_column"n=50;
RUN;
```

#                    Working with dates

```SAS
DATA output_table;
    INPUT
        @1  date_column mmddyy10.
    ;
    day_of_week_column = WEEKDAY(date_column); 
    day_of_month_column = DAY(date_column); 
    month_column = MONTH(date_column); 
    year_column = YEAR(date_column);
    date_column2 = MDY(month_column, day_of_month_column, year_column);

DATALINES;
01/25/1999
10/12/2006
;
RUN;
```

##                   Deal with mising dates

```SAS
DATA output_table;
    INPUT
        @1  date_column mmddyy10.
    ;

    IF MISSING(date_column) THEN DO;
        date_column2 = MDY(month_column,15,year_column);
    END; ELSE DO;
	    date_column2 = MDY(month_column,day_of_month_column,year_column);
    END;

DATALINES;
05/21/1999
10/12/2006
;
RUN;
```

##                   Find interval between 2 dates

```SAS
DATA output_table;
    date_column2 = INTCK('year', '01Jan2005'd, '01Jan2007'd);
    date_column6 = INTCK('semi-year', '01Jan2005'd, '01Jan2007'd);
    date_column6 = INTCK('qtr', '01Jan2005'd, '01Jan2007'd);
    date_column3 = INTCK('month', '01Jan2005'd, '01Jan2007'd);
    date_column4 = INTCK('week', '01Jan2005'd, '01Jan2007'd);
    date_column5 = INTCK('weekday', '01Jan2005'd, '01Jan2007'd);
RUN;
```

##                  Find which date will be after some interval

```SAS
DATA output_table;
    date_column1 = INTNX('month', '01Jan2005'd, 6);
    date_column2 = INTNX('month', '01Jan2005'd, 6, 'sameday');
    date_column3 = INTNX('month', '01Jan2005'd, 6, 'beginning');
    date_column4 = INTNX('month', '01Jan2005'd, 6, 'middle');
    date_column5 = INTNX('month', '01Jan2005'd, 6, 'end');
RUN;
```










#                  Create new column from formatted old one

```SAs
proc format; 
    value agefmt
        0 - <20   = '< 20' 
        20 - <40  = '20 to 39' 
        40 - <60  = '40 to 59' 
        60 - high = '60+'
    ; 
run; 

data survey; 
    set learn.survey; 
    AgeGroup = put(Age, agefmt.); 
run;
```









#                    Working with datatypes

##                   Working with numbers

###                  Round numbers

Functions:
- `INT(numeric_column)` - just truncates everything after 1 (0.6 = 0)
- `ROUND(numeric_column)` - round as in math (0.6 = 1)

```SAS
DATA output_table; 
    INPUT numeric_column1 numeric_column2; 
        numeric_column1 = INT(numeric_column1); 
        numeric_column3 = ROUND(2.2 * numeric_column2, .1); 
        numeric_column2 = ROUND(numeric_column2); 

DATALINES; 
18.8 100.7 
25.12 122.4 
64.99 188 
; 
```

###                 Mean, 2nd Largest, 2nd Smallest number of non-empty cells, number of empty cells, sum

```SAS
DATA output_table; 

    INPUT
        id_column        $
        column1-column10
    ;

    IF N(OF column1-column10) >= 7 THEN DO; /* MEAN() finds how many rows are not empty in the row */
        mean_column = MEAN(OF column1-column10);
	END; ELSE IF NMISS(OF column1-column10) >=3 THEN DO;
	    error_column = 'A lot of missing values';
	END;
    max_column = MAX(OF column1-column10); 
    min_column = MIN(OF column1-column10); 
    sum_of_non_epmty_column = SUM(OF column1-column5, column6-column10);
    sum_empty_equal_zero = SUM(0, OF OF column1-column5, column6-column10);
    third_largest = LARGEST(3, OF column1-column10);
	second_smallest_column = SMALLEST(2, OF column1-column10);

DATALINES; 
001 4 1 3 9 1 2 3 5 . 3 
002 3 5 4 2 . . . 2 4 . 
003 9 8 7 6 5 4 3 2 1 5 
;
```

###                Mathematics

```SAS
DATA math; 
    INPUT
        x @@; 
    absolute_column = ABS(x); 
    squares_column = SQRT(x); 
    exponent_column = EXP(x); 
    logarithm_column = LOG(x);
	logarithm_base_10_column = LOG10(x); 

datalines; 
2 -2 10 100 
; 
```

