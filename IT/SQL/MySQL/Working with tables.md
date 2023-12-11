# Working with tables

## Create new table 

```mysql
CREATE TABLE IF NOT EXISTS %table_name% ( /*? Many to One */
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
%lastname% VARCHAR (255) NOT NULL UNIQUE,
%table1_id% BIGINT UNSIGNED,
FOREIGN KEY (%table1_id%) REFERENCES %other_table% (id),
PRIMARY KEY (id)
);
```

# Working with columns

## Change existing column

```mysql
ALTER TABLE %table_name% CHANGE %old_column_name% %new_column_name% BIGINT NOT NULL;
```

## Add new column

```mysql
ALTER TABLE %table_name% ADD COLUMN %column_name% VARCHAR(255) NOT NULL AFTER %existing_column%;
```

## Add new constraint

```mysql
ALTER TABLE %table_name%
ADD CONSTRAINT %constraint_name%
FOREIGN KEY (%other_table_id%)
REFERENCES %other_table% (%id%)
ON DELETE RESTRICT ON UPDATE CASCADE;
```

# Working with rows

## Create new row

```mysql
INSERT INTO %table_name% (%column1%, %column2%)
VALUES (228, 'Lorem')
;
```

## Change existing row

```mysql
UPDATE %table_name%
SET %column1% = %'Lorem'%, column2 = %228%
WHERE %id% = 1
;
```

# Working with cells

## Get

```mysql
SELECT * 
FROM %table_name%
LEFT JOIN %other_table% ON %table_name%.%other_table_name_id%=%other_table_name%.id
```

### Get sum of column2 

If in your table you have some `non_unique_column1` that is not unique, you can get sum of `other_column` for every value from 

```mysql
SELECT
    %non_unique_column%,
    SUM(%number_column%),
FROM %table_name%
GROUP BY %non_unique_column%
;
```

### Count non-unique rows

```mysql
SELECT 
    %column1%, COUNT(*)
FROM %table_name%
GROUP BY %column1%;
```

### Get 2 tables with identical structure as 1

```mysql
SELECT
    table1.column1 AS output_column1,
    table1.column2
FROM
    table1
UNION ALL
SELECT
    table2.column1,
    table2.column2
FROM
    table2
ORDER BY
    output_column1
;
```

# Transactions

```mysql
START TRANSACTION;
    INSERT INTO table1 (txn_id, txn_date, table2_id, txn_type_cd, amount)
        VALUES         (1003  , NOW()   , 123       , 'D'        , 50    )
    ;
    UPDATE table2
        SET avail_balance = available_balance - 50,
            last_activity_date = NOW()
        WHERE
            table2_id = 123
    ;
COMMIT;
```