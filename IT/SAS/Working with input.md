#               Special first line

```SAS
DATA output_table; 
    IF _N_ = 1 THEN DO;
        INPUT
            special_message_column $12.
        ;
	END;
    INPUT  
	   number_column @@ 
    ;

DATALINES;
SPECIAL LINE
45000 47000 47500 48000 48000 52000 53000 55000 
67130 68000 72000 70000 65000 52000 49000 40100 
; 
```










#                  Reading data that has columns

When you have data that structured in columns:

```
12   Lorem 256
5    Ipsum 3
224  Dolor 22
1999 Sit   7777
```

You need to use this SAS code:

```SAS
data output_date;
    input
	 /* Starting_position column_name class_length.numbers_after_dot */
        @1  number_column  :  4.
        @6  text_column    : $5.
        @12 number_column2 :  4.
    ;

datalines;
12   Lorem 256
5    Ipsum 3
224  Dolor 22
1999 Sit   7777
;
```



















#                  Reading data that aren't organised into columns and has whitespaces

```SAS
data output_date;
    input
	 /* Starting_position column_name class_length.numbers_after_dot */
        number_column  /* number columns doesn not need anything */
        text_column    &      $17. /* [&] means that 1 white spaces does not count as new column (yes, data need to have 2 whitespaces) */
        number_column2 : mmddyy10. /* [:] means that you will parse something except number or text class */
    ;

datalines;
12 Lorem Ipsum  05/26/2023
5 Dolor sit  06/27/2023
224 amet, consectetur  12/12/2023
1999 adipiscing elit.  01/25/2023
;
```









#                  + sign

Besides the absolute column pointer (@), SAS also has a relative column pointer, a plus sign (+). 
You can use this to move the current pointer left or right of its current position. 
Let’s look at a few examples: You have seven readings f the variables Time and Temperature arranged in pairs—Time values are in seconds and occupy 2 bytes; Temperature values re in degrees Celsius and occupy 4 bytes. 
The data pairs start in Column 5. Here are a few sample lines of data.

If you use a relative column pointer, along with a variable and informat list, this 
simplifies to the following: 
```Sas
...
input 
    @5 (Time1-Time7)(2. + 4) 
    @7 (T1-T7)(4. + 2)
;
...
```

This INPUT statement moves the column pointer to Column 5. 
Then SAS reads a value for Time using a 2. informat and skips four spaces. 
Because there are still variables in the variable list, this informat (read two spaces and skip four) repeats for the remaining values of Time. 
Next, the pointer moves back to Column 7. 
Here you read a value of Temperature using a 4. informat and skip two spaces. 
This informat is repeated until all the values of Temperature have been read.
