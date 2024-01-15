# Default length of the columns

- Text column - 8 characters
- Numeric column - 14 integers

# Create a new one

```SAS
DATA output_table_name;
    SET temp;
    LENGTH "text_column"n $17; */n means that it is a literal in "" $ means that this is a text column. 17 sets length/*
    "text_column"n="Lorem Ipsum";
    "number_column"n=50;
RUN;
```