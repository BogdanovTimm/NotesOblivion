#                  Installation

1. Create `xTRANSFORMATION_CONFIGx.yaml` (`%filename%` will be replaced with a file to tranform):
    ```yaml
    ---
    VERSION: 1.0.0.1
    TRANSFORMATIONS:
      xTRANSFORMATION_NAMEx:
        TYPE:     input
        COMMAND:  /bin/bash /xPATH/TO/TRANSFORMATION/SCRIPTx.sh %filename%
    ```
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
4. `gpfdist -c /xPATH/TO/TRANSFORMATION_CONFIGx.yaml`
5. Create table in GreenOlum:
    ```SQL
    CREATE TABLE xTABLE_NAMEx (
        xCOLUMN1x integer,
        xCOLUMN2x decimal
    ) DISTRIBUTED BY (xCOLUMN1x)
    ```
6. Run:
    ```SQL
    CREATE READABLE EXTERNAL TABLE xTABLE_FOR_EXPORT_NAMEx (LIKE xTABLE_NAMEx)
        LOCATION ('gpfdist://xFQDN_OF_GPFDISTx:8080/xPATH/TO/FILE_TO_LOADx.xml#transform=xTRANSFORMATION_NAMEx')
        FORMAT 'TEXT' (DELIMITER '|')
        LOG ERRORS SEGMENT REJECT 
        LIMIT 10
    ;

    INSERT INTO xTABLE_NAMEx 
        SELECT * 
        FROM xTABLE_FOR_EXPORT_NAMEx;
    ```