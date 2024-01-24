#                  Create a new one

```SAS
%let global_list_of_columns = column1 column2 column3;
%let numeric_global_variable = 3;

data output_table2;
    input
        &global_list_of_columns
    ;
    new_column = &numeric_global_variable;

datalines;
1 2 3
4 5 6
7 8 9
;
```

Or using `symput()`:

```SAS
data table_to_work_with;
     input
	     column_to_generate_mean
		 column2
		 column3
	;

datalines;
1 2 3
4 5 6 
7 8 9
run;

proc means data = table_to_work_with noprint;
    var column_to_generate_mean;
    output out = table_with_means
         mean = mean_of_column
    ;
run;

data _null_;
    set table_with_means;
    call symput('new_global_variable', mean_of_column);
run;

data output_table;
    set table_to_work_with;
    Per_column = column_to_generate_mean / &new_global_variable;
run;
```









#                  Save output from some SAS function into global variable

```SAS
%let global_date_as_numeric = 30122023;
%let new_global_date = %sysfunc(inputn(&global_date_as_text, DDMMYY8.));

data output_table;
    column1 = &new_global_date;
	format
	    column1 : ddmmyy8.;
run;
```