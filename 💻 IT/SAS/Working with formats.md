#                    Show all user-defined formats in a given scheme

```SAS
TITLE "Format Definitions in the MYFMTS Library"; 
    PROC FORMAT LIBRARY = myfmts FMTLIB; /* FMTLIB prints all user-defined formats in given scheme */
RUN; 
```

#                    Save format

```SAS
LIBNAME user_defined_formats_schema 'c:\books\learning\formats';
PROC FORMAT LIBRARY = user_defined_formats_schema;
VALUE $text_format_class
    'M' = 'Male'
    'F' = 'Female'
    ' ' = 'Not entered'
    other = 'Miscoded';
RUN;
```

#                    Use user-defined format

```SAS
OPTIONS FMTSEARCH = (user_defined_formats_schema);
```

If you want for program to look for your formats first, then write:

```SAS
OPTIONS FMTSEARCH = (user_defined_formats_schema work library);
```

#                  Check SAS DATE

```SAS
DATA _NULL_;
    date = 23467;          /* SAS date format                 */
	FORMAT date YYMMDD10.; /* Human-readable format           */
	PUT date;              /* It will be written on a line 38 */
RUN;
```