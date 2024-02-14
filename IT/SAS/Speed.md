#                  Read only needed values

The first INPUT statement reads a single column to determine the value of Gender. The trailing @ prevents SAS from going to a new line. Next, if the value is not F, the DELETE statement instructs SAS not to output an observation to the SAS data set and to return control to the top of the DATA step. 

```SAS
 data females; 
 infile 'c:\books\learning\bank.txt' pad; 
 input @14 Gender $1. @; 
 if Gender ne 'F' then delete; 
 input @1 Subj $3. 
 @4 DOB mmddyy10. 
 @15 Balance 7.; 
 run; 
```