HQL is more often used than Criteria API, but less than QueryDsl

SQL:
```POSTGRESQL
SELECT
    *
FROM
    users
        LEFT JOIN
            table2 ON table2.table1_id = table1.id
WHERE
    column1 = "Lorem"
ORDER BY
    table1.clumn3 ASC
```

HQL:
```Java
"
SELECT
    u
FROM
    User as u
        LEFT JOIN
            u.column2 as c
WHERE
    u.column1 = 'Lorem'
ORDER BY
    u.column3 ASC
"
```

Using variables inside HQL:
```JAVA
String variable1 = "Lorem";
String variable2 = "Ipsum";
var result = database1.createQuery (
                                    "SELECT u" + 
                                    "FROM Table1 as u" +
                                        "LEFT JOIN u.column2 as c" +
                                    "WHERE u.column1 = :variableInsideHQL" +
                                    "AND" +
                                    "c.column2 = :variableInsideHQL2"
                                    ,
                                    Table1.class
                                   )
                      .setParameter (variableInsideHQL, variable1)
                      .setParameter (variableInsideHQL2, variable2)
                      .list ()
;
```

If you return not row, but a value (for example after using som SQL-function), then use:
```JAVA
database1.createQuery (
                       "SELECT AVG(p.column1)" +
                       "FROM Table1 AS p"
                       ,
                       Double.class
                       )
         .uniqueResult ()
;
```

If you use `GROUP BY`, then use:

```JAVA
database1.createQuery (
                       "SELECT c.column1, AVG(p.column2)" +
                       "FROM Table1 AS c"+
                       "INNER JOIN c.column3 AS u" +
                       "INNER JOIN u.column4 as P" +
                       "GROUP BY c.column1" +
                       "ORDER BY c.column1"
                       ,
                       Object [].class
                       )
         .list ()
;
```

Types of queries:
- Get:
```JAVA
var result = database1.createQuery (
                                    "SELECT u" + 
                                    "FROM Table1 as u" +
                                        "LEFT JOIN u.column2 as c" +
                                    "WHERE u.column1 = :variableInsideHQL" +
                                    "AND" +
                                    "c.column2 = :variableInsideHQL2"
                                    ,
                                    Table1.class
                                   )
                      .setParameter (variableInsideHQL, variable1)
                      .setParameter (variableInsideHQL2, variable2)
                      .setFlushMode (FlushModeType.AUTO) // Default. It is rarely changed. Whether to update SQL Database before run this query or not
                      .setHint (QueryHints.FETCH_SIZE, "50") // sets fetch size
                      .setMaxResults (10) // Ho many rows to return
                      .list ()
;
```
- Change row:
```JAVA
var result = database1.createQuery (
                                    "UPDATE User as u" +
                                    "SET u.column1 = 'LOREM'"
                                   )
                       .executeUpdate ();
```

# Using Native SQL

```JAVA
database1.createNativeQuery ("SELECT * FROM table1 AS u WHERE u.column1 = 'IVAN'"
                             ,
                             Table1.class
                            )
```
