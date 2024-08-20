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
CREATE WRITABLE EXTERNAL TEMPORARY TABLE 
    xTABLENAMEx (
        xCOLUMN1x xINTEGERx,
        xCOLUMN2x xINTEGERx
    )
LOCATION ('gpfdist://Xserver.ruX:X55551X/Xpath/to/file/from/gpfdist/open/folderX.txt')
FORMAT 'TEXT' (DELIMITER ',')
;

INSERT INTO xTABLENAMEx (
    xCOLUMN1x,
    xCOLUMN2x
) VALUES (1,2),
         (3,4)
;

;
```