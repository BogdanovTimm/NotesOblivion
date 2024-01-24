#                  System date and time

Current date:

```SAS
data output_table;
     current_date = "&SYSDATE";
     current_time = "&SYSTIME";
run;
```










#                  Using environmental variables in Data

```SAS
data output_table;
    home = sysget('HOME');
    user = sysget('USER');
run;
```











#                  Using environmental variables global

```SAS
%let global_variable = %sysget('HOME');
```