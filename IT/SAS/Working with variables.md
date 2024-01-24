#                  Create variable that is out of SAS'es loop










##                 Creating variables outside of a SAS loop

You can create variable as a new column that will store value. This value will not be overwritten when SAS will iterate to the next row:

```SAS
retain column_name;
```











##                 Creating Global variables

See [Global variables.md] (IT/SAS/Global variables.md)