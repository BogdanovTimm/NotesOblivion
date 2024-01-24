#                  Sort

```SAS
PROC SORT DATE = database_name.table_name OUT = copy_of_table_name; 
    BY column_to_sort_by;
RUN;
```











#                  Means

`PROC SUMMARY DATA = table_name NOPRINT` is equal to `PROC MEANS DATA = table_name NOPRINT`

```SAS
DATA output_table; 
    INPUT  
	   number_column1
	   number_column2
	   number_column3
    ;

DATALINES;
45000 47000 47500 
48000 48000 52000 
53000 55000 67130 
68000 72000 70000 
65000 52000 49000 
40100 . .
;

PROC MEANS DATA = Work.output_table NOPRINT 
/* NWAY             - use this if you don't want grand mean in output table, if you use CLASS */ 
/* CHARTYPE         - use this everytime you use CLASS */ 
ORDER = INTERNAL /* - availeble options: FORMATTED, DATA, FREQ*/
    N      /* Number of non-empty values           */
    NMISS  /* Number of empty values               */
    MEAN   /* Mean or Average                      */
    SUM    /* Sum of all values in column          */
    MEDIAN /* Median value                         */
    MIN    /* Minimum non-empty value in column    */
    MAX    /* Maximum value in column              */
    STD    /* Standard derivation                  */
    VAR    /* Variance                             */
    CLM    /* 95% confidence interval for the mean */
    Q1     /* Value of the 1st quartile (25%)      */
    Q3     /* Value of the 3d quartile (75%)       */
    QRANGE /* Interquartile range (Q3 - Q1)        */
    
    MAXDEC = 1 /* number of integers after '.' in each statictic */
    ; 
    
    CLASS       /* If columns are not yet sorted */
        number_column1
        number_column2
    ;

    /* WHERE _TYPE_ = '10';  If you use CLASS and want only specific means */

    FORMAT
        column1 column1_formatter.
    ;

    /* If columns are sorted already
    BY
           column1
           column2;
    */
    
    

    VAR         /* To wich columns to apply statistics */
        number_column1
        number_column2
    ;
    OUTPUT OUT = new_statistics_table
	    MEAN = mean_number_column1
		       mean_number_column2
		SUM  = sum_number_column1
		       sum_number_column2
	    N    = non_empty_number_column1
		       non_empty_number_column2
    ;

    /* Alternative output
    OUTPUT OUT = new_statistics_table
        MEAN (column1, column2) =
        SUM (column1, column2) =
        N (column1, column2) =
            / autoname
    ;
    */

    /*
    IF _TYPE_ = '00' THEN OUTPUT table1;
    ELSE IF _TYPE_ = '01' THEN OUTPUT table2;
    */
RUN; 
```

```SAS
PROC MEANS DATA = learn.blood NOPRINT CHARTYPE; 
    CLASS Gender AgeGroup; 
    VAR RBC WBC; 
    OUTPUT
        OUT = SUMMARY 
        MEAN(column1 column2) = 
        N = / autoname; 
RUN;
```





















#                  Frequences analysis

```Sas
PROC FREQ DATA = database_name.table_to_work_with; 
    TABLES
        column1 
        /*  / NOCUM     - If you don't want cumulative frequences */
        /*    NOPERCENT - If you dont' want percentages */
        column2
    ;
    FORMAT /* You  can use [FORMAT] to groupify output */
        number_column        two.
        text_column   $formatter.
    ; 
RUN; 

proc freq data = learn.grouping; 
format X two.; 
tables X; 
run; 
```









##                 Groupify using [FORMAT]

```SAS
proc format; 
    value agegroup 
        low-<30 = 'Less than 30' 
        30-<60  = '30 to 59' 
        60-high = '60 and higher'
        .       = 'Missing'
        other   = 'Other values'
    ; 
    value $agree_disagree 
        '1', '2' = 'Generally disagree' 
        '3'      = 'No opinion' 
        '4', '5' = 'Generally agree'
    ; 
run;   

proc freq data=learn.survey; 
    tables
        Age
        Ques5 
            / nocum
              nopercent
    ; 
    format 
        Age          agegroup. 
        Ques5 $agree_disagree.
    ; 
run;
```










##                 Missing

Not only does this option bring the count of missing values up into the main table, it also changes how SAS reports percentages. 

Without the `MISSING` option, percentages are computed as the frequency of each ategory divided by the number of non-missing values; with the `MISSING`` option, SAS computes frequencies by dividing he frequencies by the number of missing and non-missing observations. 

```Sas
proc freq data = learn.grouping; 
tables X / missing; 
format X two.; 
run; 

proc freq data = learn.grouping; 
format X two.; 
tables X; 
run; 
```











##                 Matrix tables

```SAS
proc freq data = database_name.table_to_work_with; 
    tables
        column1 * column2 * column3
    ; 
run; 
```

Or more complex ones:

```SAS
proc freq data = database_name.table_to_work_with; 
    tables
        column1 * (column2 column2)
    ; 
run; 
```