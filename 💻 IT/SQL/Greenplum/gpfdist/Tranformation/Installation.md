#                  Installation

Transformation script is expected to open the underlying file(s) as appropriate and produce one line of TEXT for each row to load into Greenplum Database. The input transform determines whether the entire content should be converted to one row or to multiple rows.

1. Create `xTRANSFORMATION_CONFIGx.yaml` (`%filename%` will be replaced with a file to tranform):
```yaml
---
VERSION: 1.0.0.1
TRANSFORMATIONS:
  xTRANSFORMATION_NAMEx:
    TYPE   : input
    COMMAND: /bin/bash /xPATH/TO/TRANSFORMATION/SCRIPTx.sh %filename%
    # CONTENT: {data|paths}     # Optional
    # SAFE   : xREGEXPx         # Optional
    # STDERR : {server|console} # Optional
```
Where:
    * `COMMAND` - Transformation script is expected to open the underlying file(s) as appropriate and produce one line of TEXT for each row to load into Greenplum Database. The input transform determines whether the entire content should be converted to one row or to multiple rows.
    * `CONTENT` - Optional. Possible values:
        * `data` - text `%filename%` in the `COMMAND` section is replaced by the path to the file to read or write
        * `paths` -  the text `%filename%` in the `COMMAND` section is replaced by the path to the temporary file that contains the list of files to read or write
    * `SAFE` - Optional. A POSIX regular expression that the paths must match to be passed to the transformation. The default is no restriction on paths.
    * `STDERR` - Optional. Possible values:
        * `server` - send first 8k of standard error to GreenPlum Database as an error message.
        * `console` - do not redirect the standard error output from the transformation
2. Create a transformation script
3. Create a `gpload_config.yaml`:
```yaml
---
VERSION:  1.0.0.1
DATABASE: ops
USER:     gpadmin
GPLOAD:
  INPUT:
    - TRANSFORM_CONFIG: /xPATH/TO/TRANSFORMATION_CONFIGx.yaml
    - TRANSFORM:        xTRANSFORMATION_NAMEx
    - SOURCE:
        FILE: /xPATH/TO/FILE_TO_LOADx.xml
```
4. `gpfdist -c /xPATH/TO/TRANSFORMATION_CONFIGx.yaml -I xDEFAULT_TRANSFORMATION_IN_CONFIG_NAMEx`
5. Create table in GreenOlum:
```SQL
CREATE TABLE xTABLE_NAMEx (
    xCOLUMN1x integer,
    xCOLUMN2x decimal
) DISTRIBUTED BY (xCOLUMN1x)
```
6. Run:
```SQL
CREATE READABLE EXTERNAL TABLE 
    xTABLE_FOR_EXPORT_NAMEx (LIKE xTABLE_NAMEx)
    LOCATION ('gpfdist://xFQDN_OF_GPFDISTx:8080/xPATH/TO/FILE_TO_LOADx.xml#transform=xTRANSFORMATION_NAMEx')
    FORMAT 'TEXT' (DELIMITER '|')
    LOG ERRORS SEGMENT REJECT 
    LIMIT 10
;
INSERT INTO xTABLE_NAMEx 
    SELECT * 
    FROM xTABLE_FOR_EXPORT_NAMEx
;
```