# Working with tables

## Creating a new one

```postgresql
CREATE TABLE %table_name% (  
	id      BIGSERIAL NOT NULL PRIMARY KEY,  
	%other_table_id% BIGSERIAL NOT NULL,  
	%string_column% VARCHAR(255) NOT NULL,  
	%date_column% TIMESTAMP NOT NULL,
	FOREIGN KEY (%other_table_id%) REFERENCES %other_table% (id) ON DELETE CASCADE ON UPDATE CASCADE,  
	CONSTRAINT %UQ_table_name_other_table_id% UNIQUE (%other_table_id%),  
	CONSTRAINT %UQ_table_name_string_column% UNIQUE (%string_column%),
	PRIMARY KEY (id, %string_column%)
);
```

# Working with columns

## Change an existing one

```postgresql
ALTER TABLE %table_name% 
    ALTER COLUMN %old_column_name% TYPE %BIGINT%
    RENAME %old_column_name% TO %new_column_name%
;
```

## Create a new one

```postgresql
ALTER TABLE %table_name%
    ADD COLUMN %new_column% %BIGINT%
;
```

## Delete

```postgresql
ALTER TABLE %table_name%
    ALTER COLUMN %existing_column% DROP NOT NULL
;
```

# Working with constraints

## Add constraint

```postgresql
ALTER TABLE %table_name% ADD CONSTRAINT %constraint_name% UNIQUE (%column1%);
ALTER TABLE %table_name% ADD FOREIGN KEY (%table_name_other_table_id%) REFERENCES %other_table%;
```

## Chane an existing one

As in Mysql's [[IT/SQL/MySQL/Working with tables|Working with tables]], you can only delete an old one and create a new one.

## Delete constraint

```postgresql
ALTER TABLE %tablename%
	DROP CONSTRAINT %constraintname%
;
```


# Working with rows

## Add new one

```postgresql
INSERT INTO %table_name%
           (%column1%,    %column2%)
    VALUES ('Lorem Ipsum', 106     )
;
```

## Change an existing one

```postgresql
UPDATE %table_name% 
    SET %column1% = 'Lorem'
    WHERE %column2% = 'Ipsum'
;
```

## Delete

```postgresql
DELETE FROM %tablename%
	WHERE %other_tablename_id% IN (
		SELECT id
		    FROM %other_table%
		    WHERE %column2% = %'Lorem'%
	)
;
```

# Working with cells

## Get

```postgresql
SELECT %tablename%.%column1%, %tablename%.%column2%,
    FROM %tablename% JOIN %othertable% USING (%column2%)
;
```

### Count non-unique rows

```postgresql
SELECT %column1%,
       COUNT(*)
    FROM %table_name%
    GROUP BY %column1%
;
```

### Get sum of column2 

```postgresql
SELECT %column1%,
       sum(%column2%) AS total
    FROM %tablename%
    GROUP BY %column1%
    HAVING sum(%column2%) < interval '5 hours'
;
```

### Get 2 tables with identical structure as 1

```postgresql
SELECT
    table1.column1 AS output_column1,
    table1.column2
    FROM table1
UNION ALL
    SELECT
        table2.column1,
        table2.column2
    FROM table2
    ORDER BY output_column1
;
```

# Transactions

```postgresql
BEGIN;
    UPDATE %table1%
        SET %column2% = %column2% - 100.00
        WHERE %column1% = %'Lorem'%
    ;
    SAVEPOINT %savepoint1%;
    UPDATE %table1%
        SET %column2% = %column2% + 100.00
        WHERE %column1% = %'Ipsum'%
    ;
    -- oops ... forget that and use Wally's account
    ROLLBACK TO %savepoint1%;
    UPDATE %table1%
        SET %column2% = %column2% + 100.00
        WHERE %column1% = %'Dolor'%
    ;
COMMIT;
```