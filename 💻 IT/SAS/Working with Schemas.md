- `libname library_name` - already existing one
```SAS
LIBNAME
    LibName1 /* Max length must be 8 characters */
    'c:\path\to\folder\with\tables.sas7bdat'
```

#                   Create a new one


#                   View all existing ones

```SAS
TITLE "Listing tables in a schema";
    PROC CONTENTS DATA = schema_name._all_ NODS;
RUN;
```