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