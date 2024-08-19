#                  Types of External tables

2 Types of external tables:
- Readable - read-only
- Writable - write-only

#                  Code

##                 Working with Read-only table

```SQL
CREATE READABLE EXTERNAL TABLE 
    XschemaX.XtableX (
        Xcolumn1X XintX
    )
LOCATION ('gpfdist://Xserver.ruX:X55551X/Xpath/to/file/from/gpfdist/open/folderX.csv')
FORMAT 'CSV' (DELIMETER ',')
;

SELECT *
FROM XschemaX.XtableX
;
```



##                 Working with Write-only table

```SQL
CREATE WRITABLE EXTERNAL TABLE 
    XschemaX.XtableX (
        Xcolumn1X XintX
    )
LOCATION ('gpfdist://Xserver.ruX:X55551X/Xpath/to/file/from/gpfdist/open/folderX.csv')
FORMAT 'CSV' (DELIMETER ',')
;

INSERT INTO
    XschemaX.XtableX (
        Xcolumn1X,
        Xcolumn2X
    )
    VALUES (
        1,
        2
    )
;
```