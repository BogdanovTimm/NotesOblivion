

- `libname library_name` - already existing one
- `libname library_name 'c:\path\to\schema'` - local one

#                   Create a new one


#                   View all existing ones

```SAS
TITLE "Listing tables in a schema";
    PROC CONTENTS DATA = schema_name._all_ NODS;
RUN;
```